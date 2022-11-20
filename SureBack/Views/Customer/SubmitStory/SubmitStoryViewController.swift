//
//  SubmitStoryViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 15/11/22.
//

import UIKit

class SubmitStoryViewController: UIViewController {
    let request = RequestFunction()
    var user: UserInfoResponse?
    var tokenData: GenerateTokenOnlineResponse?
    var storyData = [ResultStoryIG]() {
        didSet {
            tableView.reloadData()
        }
    }

    var userIgInfo: ProfileIGResponse? {
        didSet {
            tableView.reloadData()
        }
    }

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SubmitStoryTableViewCell.self, forCellReuseIdentifier: SubmitStoryTableViewCell.id)
        table.backgroundColor = .white
        table.separatorColor = UIColor.clear
        return table
    }()

    let footerView = UIView()
    let doneButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        guard let tokenData = tokenData, let storyID = tokenData.story?.id else {
            return
        }

        let headerView = HeaderSubmitStoryView(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 180))
        headerView.tokenIdLabel.text = String(tokenData.id)
        headerView.merchantNameLabel.text = tokenData.merchant.name

        // string to date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: tokenData.createdAt)
        dateFormatter.dateFormat = "dd MMM yyyy"
        let dateString = dateFormatter.string(from: date!)

        // date to string
        let dateToString = DateFormatter()
        dateToString.dateFormat = "dd/MM/YY"

        headerView.dateNameLabel.text = dateString
        headerView.purchaseNameLabel.text = String(tokenData.purchase.purchaseAmount)
        print("Story ID: \(storyID)")

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        setupTableView()

        request.getProfileIG(username: user?.instagramUsername ?? "") { data in
            switch data {
            case let .success(result):
                do {
                    self.userIgInfo = result
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to get profile IG")
            }
        }

        // req mention story
//        request.getStoryIG(storyId: storyID) { data in
//            switch data {
//            case let .success(result):
//                do {
//                    print(result.data[0].mediaType)
//                    self.storyData = result.data
//                } catch let error as NSError {
//                    print(error.description)
//                }
//            case let .failure(error):
//                print(error)
//                print("failed to get mention story")
//            }
//        }
        // coba pake data postman
        setupDummyData()
    }

    func setupDummyData() {
        let jsonString = """
                {
                    "data": [
                        {
                            "id": 2974680228980292666,
                            "taken_at": 1668829535,
                            "expiring_at": 1668915935,
                            "media_type": 1,
                            "image_url": "https://scontent-xsp1-3.cdninstagram.com/v/t51.2885-15/316174705_865272601325584_6553075942242657412_n.jpg?stp=dst-jpg_e35&_nc_ht=scontent-xsp1-3.cdninstagram.com&_nc_cat=104&_nc_ohc=3DuKYjCtQ64AX_HaCOD&tn=7TOd10cqrVANAHgk&edm=ANmP7GQBAAAA&ccb=7-5&ig_cache_key=Mjk3NDY4MDIyODk4MDI5MjY2Ng%3D%3D.2-ccb7-5&oh=00_AfCF1fu8znosyxYd8PZWF3shCIwwpqijemOThvvzSnUDoQ&oe=637A42C4&_nc_sid=276363",
                            "video_url": null,
                            "music_metadata": null,
                            "story_url": "https://www.instagram.com/stories/ditpages/2974680228980292666/",
                            "submitted_at": null
                        },
                        {
                            "id": 2974680429929408945,
                            "taken_at": 1668829560,
                            "expiring_at": 1668915960,
                            "media_type": 1,
                            "image_url": "https://scontent-xsp1-3.cdninstagram.com/v/t51.2885-15/315993592_528825515499891_8134211913082908002_n.jpg?stp=dst-jpg_e35&_nc_ht=scontent-xsp1-3.cdninstagram.com&_nc_cat=103&_nc_ohc=RXOBty6ZLN4AX99QxwH&edm=ANmP7GQBAAAA&ccb=7-5&ig_cache_key=Mjk3NDY4MDQyOTkyOTQwODk0NQ%3D%3D.2-ccb7-5&oh=00_AfDjz1hFdkxUsVn5L7EDdgBUrTi8e7SRObAlvCXuUMU12g&oe=637A306A&_nc_sid=276363",
                            "video_url": null,
                            "music_metadata": null,
                            "story_url": "https://www.instagram.com/stories/ditpages/2974680429929408945/",
                            "submitted_at": null
                        },
                        {
                            "id": 2974680685798627605,
                            "taken_at": 1668829591,
                            "expiring_at": 1668915991,
                            "media_type": 1,
                            "image_url": "https://scontent-xsp1-3.cdninstagram.com/v/t51.2885-15/316057742_522302429813089_7816838386891056915_n.jpg?stp=dst-jpg_e35&_nc_ht=scontent-xsp1-3.cdninstagram.com&_nc_cat=101&_nc_ohc=Ueo2FbtWSwkAX9IwNc2&edm=ANmP7GQBAAAA&ccb=7-5&ig_cache_key=Mjk3NDY4MDY4NTc5ODYyNzYwNQ%3D%3D.2-ccb7-5&oh=00_AfAlQLcSy8YnPlvtlxwDhlw4bEb9UiIoVzFZmWDpVy_71g&oe=6379DDBF&_nc_sid=276363",
                            "video_url": null,
                            "music_metadata": null,
                            "story_url": "https://www.instagram.com/stories/ditpages/2974680685798627605/",
                            "submitted_at": null
                        }
                    ]
                }
        """

        do {
            let story = try JSONDecoder().decode(ResponseData<ResultStoryIG>.self, from: Data(jsonString.utf8))
            print(story)
            print(story.data[0].mediaType)
            storyData = story.data
        } catch {
            print(error)
        }
    }

    @objc func submitStoryTapped() {
        print("submit story button tapped")
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
        cell.userIgInfo = userIgInfo

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        doneButton.setTitle("Redeem", for: .normal)
        doneButton.backgroundColor = .systemBlue
        doneButton.layer.cornerRadius = 10.0
        doneButton.addTarget(self, action: #selector(submitStoryTapped), for: .touchUpInside)
        footerView.addSubview(doneButton)

        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setCenterXAnchorConstraint(equalTo: footerView.centerXAnchor)
        doneButton.setCenterYAnchorConstraint(equalTo: footerView.centerYAnchor)
        doneButton.setWidthAnchorConstraint(equalToConstant: 100)

        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
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
