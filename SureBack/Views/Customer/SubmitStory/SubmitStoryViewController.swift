//
//  SubmitStoryViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 15/11/22.
//

import UIKit

class SubmitStoryViewController: UIViewController, SendDataDelegate {
    let activeTokensViewModel = ActiveTokensViewModel.shared
    let request = RequestFunction()
    var user: UserInfoResponse?
    var tokenData: Token?
    var userIgInfo: ProfileIGResponse? {
        didSet {
            tableView.reloadData()
        }
    }

    var storyData = [ResultStoryIG]() {
        didSet {
            tableView.reloadData()
        }
    }

    var igStoryId: Int?

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SubmitStoryTableViewCell.self, forCellReuseIdentifier: SubmitStoryTableViewCell.id)
        table.backgroundColor = .white
        table.separatorColor = UIColor.clear
        return table
    }()

    private var loadingService: LoadingService?

    var loadingIndicator: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.style = .gray
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.hidesWhenStopped = true
        return loading
    }()

    lazy var alertWaiting: UIAlertController = {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        return alert
    }()

    let headerView = HeaderSubmitStoryView(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 280))
    let footerView = UIView()
    let doneButton = UIButton()

    var countdown: DateComponents {
        return Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: tokenData?.expiresAt.stringToDate() ?? Date())
    }

    func passData(data: Int) {
        igStoryId = data
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true

        let redeemButton = UIBarButtonItem(title: "Redeem", style: .done, target: self, action: #selector(submitStoryTapped))
        navigationItem.rightBarButtonItem = redeemButton

        loadingService = LoadingService(loadingIndicator: loadingIndicator)
        loadingService?.setState(state: .loading)

        guard let tokenData = tokenData, let storyID = tokenData.story?.id else {
            return
        }

        headerView.tokenIdValueLabel.text = String(tokenData.id)
        headerView.merchantNameValueLabel.text = tokenData.purchase?.merchant?.name
        headerView.dateValueLabel.text = tokenData.createdAt.formatTodMMMyyyhmma()
        headerView.purchaseValueLabel.text = String(tokenData.purchase?.purchaseAmount ?? 0)
        runCountdown()
        print("Story ID: \(storyID)")

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        setupTableView()

        request.getProfileIG(username: user?.instagramUsername ?? "") { [weak self] data in
            guard let self = self else { return }
            switch data {
            case let .success(result):
                do {
                    self.userIgInfo = result
                    if result.isPrivate {
                        let alert = UIAlertController(title: "Your IG account is Private", message: "Please set your IG account to public", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("Try Again", comment: "Default action"), style: .default))
                        self.present(alert, animated: true, completion: nil)
                    }
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to get profile IG")
            }
        }

        // req mention story
        request.getStoryIG(storyId: storyID) { [weak self] data in
            guard let self = self else { return }
            switch data {
            case let .success(result):
//                if result.data.isEmpty { break }
                self.storyData = result.data.filter { $0.submittedAt == nil }
                self.loadingService?.setState(state: .success)
            case let .failure(error):
                print(error)
                print("failed to get mention story")
                self.loadingService?.setState(state: .failed)
                self.showAlert(title: "Failed to get story Instagram", message: "Try Again", action: "Okay")
            }
        }
        // coba pake data postman
//        setupDummyData()
    }

//    func setupDummyData() {
//        let jsonString = """
//                {
//                    "data": [
//                        {
//                            "id": 2974680228980292666,
//                            "taken_at": 1668829535,
//                            "expiring_at": 1668915935,
//                            "media_type": 1,
//                            "image_url": "https://scontent-xsp1-3.cdninstagram.com/v/t51.2885-15/316174705_865272601325584_6553075942242657412_n.jpg?stp=dst-jpg_e35&_nc_ht=scontent-xsp1-3.cdninstagram.com&_nc_cat=104&_nc_ohc=3DuKYjCtQ64AX_HaCOD&tn=7TOd10cqrVANAHgk&edm=ANmP7GQBAAAA&ccb=7-5&ig_cache_key=Mjk3NDY4MDIyODk4MDI5MjY2Ng%3D%3D.2-ccb7-5&oh=00_AfCF1fu8znosyxYd8PZWF3shCIwwpqijemOThvvzSnUDoQ&oe=637A42C4&_nc_sid=276363",
//                            "video_url": null,
//                            "music_metadata": null,
//                            "story_url": "https://www.instagram.com/stories/ditpages/2974680228980292666/",
//                            "submitted_at": null
//                        },
//                        {
//                            "id": 2974680429929408945,
//                            "taken_at": 1668829560,
//                            "expiring_at": 1668915960,
//                            "media_type": 1,
//                            "image_url": "https://scontent-xsp1-3.cdninstagram.com/v/t51.2885-15/315993592_528825515499891_8134211913082908002_n.jpg?stp=dst-jpg_e35&_nc_ht=scontent-xsp1-3.cdninstagram.com&_nc_cat=103&_nc_ohc=RXOBty6ZLN4AX99QxwH&edm=ANmP7GQBAAAA&ccb=7-5&ig_cache_key=Mjk3NDY4MDQyOTkyOTQwODk0NQ%3D%3D.2-ccb7-5&oh=00_AfDjz1hFdkxUsVn5L7EDdgBUrTi8e7SRObAlvCXuUMU12g&oe=637A306A&_nc_sid=276363",
//                            "video_url": null,
//                            "music_metadata": null,
//                            "story_url": "https://www.instagram.com/stories/ditpages/2974680429929408945/",
//                            "submitted_at": "2022-11-25T12:48:24.000000Z"
//                        },
//                        {
//                            "id": 2974680685798627605,
//                            "taken_at": 1668829591,
//                            "expiring_at": 1668915991,
//                            "media_type": 1,
//                            "image_url": "https://scontent-xsp1-3.cdninstagram.com/v/t51.2885-15/316057742_522302429813089_7816838386891056915_n.jpg?stp=dst-jpg_e35&_nc_ht=scontent-xsp1-3.cdninstagram.com&_nc_cat=101&_nc_ohc=Ueo2FbtWSwkAX9IwNc2&edm=ANmP7GQBAAAA&ccb=7-5&ig_cache_key=Mjk3NDY4MDY4NTc5ODYyNzYwNQ%3D%3D.2-ccb7-5&oh=00_AfAlQLcSy8YnPlvtlxwDhlw4bEb9UiIoVzFZmWDpVy_71g&oe=6379DDBF&_nc_sid=276363",
//                            "video_url": null,
//                            "music_metadata": null,
//                            "story_url": "https://www.instagram.com/stories/ditpages/2974680685798627605/",
//                            "submitted_at": null
//                        }
//                    ]
//                }
//        """
//
//        do {
//            let story = try JSONDecoder().decode(ResponseData<ResultStoryIG>.self, from: Data(jsonString.utf8))
//            print(story)
//            print(story.data[0].mediaType)
//            storyData = story.data.filter{ $0.submittedAt == nil }
//        } catch {
//            print(error)
//        }
//    }

    // MARK: Timer

    func runCountdown() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        let countdown = self.countdown
        let hours = countdown.hour!
        let minutes = countdown.minute!
        let seconds = countdown.second!

        headerView.timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    @objc func submitStoryTapped() {
//        guard let follsIG = userIgInfo?.followerCount, follsIG >= 100 else {
//            let alert = UIAlertController(title: "Not enough followers", message: "Please increase your follower to >= 100", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: NSLocalizedString("Try Again", comment: "Default action"), style: .default))
//            self.present(alert, animated: true, completion: nil)
//
//            return
//        }

        guard let storyId = tokenData?.story?.id, let igStoryId = igStoryId else {
            let okActionBtn = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            let alert = UIAlertController(title: "Failed to Submit", message: "Choose Story First", preferredStyle: .alert)
            alert.addAction(okActionBtn)
            present(alert, animated: true)

            return
        }

        present(alertWaiting, animated: true)

//        request submit story
        request.submitStory(storyId: storyId, instagtamStoryId: igStoryId) { [weak self] data in
            guard let self = self else { return }
            switch data {
            case .success:
                self.activeTokensViewModel.removeWhere(storyId: storyId)
                self.alertWaiting.dismiss(animated: true) {
                    let okActionBtn = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                        self.navigationController?.popViewController(animated: true)
                    })
                    let alert = UIAlertController(title: "Success", message: "Success Submit Story", preferredStyle: .alert)
                    alert.addAction(okActionBtn)
                    self.present(alert, animated: true)
                }
            case .failure:
                self.alertWaiting.dismiss(animated: true) {
                    let okActionBtn = UIAlertAction(title: "Try Again", style: .cancel, handler: nil)
                    let alert = UIAlertController(title: "Failed to Submit Story", message: "", preferredStyle: .alert)
                    alert.addAction(okActionBtn)
                    self.present(alert, animated: true)
                }
            }
        }
    }
}

extension SubmitStoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SubmitStoryTableViewCell.id, for: indexPath) as? SubmitStoryTableViewCell else { return UITableViewCell() }

        cell.storyData = storyData
        cell.user = user
        cell.merchantData = tokenData?.purchase?.merchant
        cell.userIgInfo = userIgInfo
        cell.delegate = self

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

extension SubmitStoryViewController {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        tableView.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        tableView.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        tableView.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    }
}
