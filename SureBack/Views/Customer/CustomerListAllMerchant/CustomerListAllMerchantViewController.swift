//
//  CustomerListAllMerchantViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 23/11/22.
//

import UIKit
import SDWebImage

class CustomerListAllMerchantViewController: UIViewController {
    let request = RequestFunction()
    var user: UserInfoResponse?
    var merchantData = [UserInfoResponse]()
    var activeTokenData = [Token]()

    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .minimal
        search.placeholder = "Search.."
        search.sizeToFit()
        return search
    }()

    lazy var loadingIndicator: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.style = .gray
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.isHidden = true
        return loading
    }()

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ItemMerchantTableViewCell.self, forCellReuseIdentifier: ItemMerchantTableViewCell.id)
        table.separatorColor = .clear
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        showLoadingIndicator(true)
        searchBar.delegate = self
        setupLayout()
        getListAllMerchant()
    }

    func getListAllMerchant(search searchedName: String = "") {
        request.getListMerchant(searchMerchantByName: searchedName) { [weak self] data in
            guard let self = self else {return}
            switch data {
            case let .success(result):
                do {
                    self.merchantData = result.data
                    self.tableView.reloadData()
                    self.showLoadingIndicator(false)
                } catch let error as NSError {
                    print(error.description)
                }
            case let .failure(error):
                print(error)
                print("failed to get list merchant")
            }
        }
    }

    private func showLoadingIndicator(_ isShow: Bool) {
        tableView.isHidden = isShow
        loadingIndicator.show(isShow)
    }

    @objc func bookmarkTapped(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else {return}
        DispatchQueue.global(qos: .userInteractive).async {
            self.request.toggleMerchantFavorited(id: self.merchantData[tag].id) {  response in
    //            guard let self = self else {return}
                switch response {
                case .success(let result):
                    let indexPath = IndexPath(row: tag, section: 1)
                    let cell = self.tableView.cellForRow(at: indexPath) as? ItemMerchantTableViewCell
                    self.merchantData[tag].isFavorite = result.isFavorite
                    guard let isFavorite = result.isFavorite else {return}
                    let image = isFavorite ? "bookmark.on" : "bookmark.off"
                    DispatchQueue.main.async {
                        cell?.bookmarkImage.image = UIImage(named: image)
                        self.tableView.reloadData()
                    }
                case let .failure(error):
                    print(error)
                    print("failed to bookmarked the merchant")
                }
            }
        }
    }
}

extension CustomerListAllMerchantViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        showLoadingIndicator(true)
        print("Hasil pencarion", searchText.lowercased())
        getListAllMerchant(search: searchText.lowercased())
    }
}

extension CustomerListAllMerchantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if merchantData.count == 0 {
            self.tableView.setEmptyMessage(
                image: UIImage(named: "empty.merchant")!,
                title: "Empty Merchant",
                message: "Let’s Get Going! Which Merchant will be your First Visit?",
                centerYAnchorConstant: -50)
        } else {
            self.tableView.restore()
        }
        return merchantData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemMerchantTableViewCell.id, for: indexPath) as? ItemMerchantTableViewCell else { return UITableViewCell() }

        cell.selectionStyle = .none
        cell.backgroundColor = .porcelain

        cell.merchantImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.merchantImage.sd_setImage(
            with: URL(string: merchantData[indexPath.row].profilePicture ?? ""),
            placeholderImage: UIImage(named: "system.photo"),
            options: .progressiveLoad,
            completed: nil
        )
        cell.merchantNameLabel.text = merchantData[indexPath.row].name
        cell.totalCoinsLabel.text = "\(merchantData[indexPath.row].balance) coin(s)"
        cell.bookmarkImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bookmarkTapped)))
        cell.bookmarkImage.tag = indexPath.row
        cell.bookmarkImage.isUserInteractionEnabled = true
        if let isFavorite = merchantData[indexPath.row].isFavorite {
            let image = isFavorite ? "bookmark.on" : "bookmark.off"
            cell.bookmarkImage.image = UIImage(named: image)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let merchantDetailVC = CustomerHistoryViewController()
        merchantDetailVC.title = "Merchant"
        merchantDetailVC.user = user
        merchantDetailVC.merchantData = merchantData[indexPath.row]
        for i in activeTokenData {
            if i.purchase?.merchant?.id == merchantData[indexPath.row].id {
                merchantDetailVC.tokenData = i
                break
            }
        }
        navigationController?.pushViewController(merchantDetailVC, animated: true)
    }
}
