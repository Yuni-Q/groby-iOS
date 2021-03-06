//
//  MakeTab1FourthViewController.swift
//  groby
//
//  Created by 이재성 on 12/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MakeTab1FourthViewController: UIViewController {

    @IBOutlet weak var tabMenuView: UIView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var minimumCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet var tabButtons: [UIButton]!
    @IBOutlet var tabButtonSelectedViews: [UIView]!
    @IBOutlet var headerTabButtons: [UIButton]!
    @IBOutlet var headerTabButtonSelectedViews: [UIView]!

    var tabNumber: Int? = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setCustomTitle("글 미리보기")

        //        CommonDataManager.share.item?.tabOne?.contents
        //        CommonDataManager.share.item?.tabOne?.location

        if let imageURLs = CommonDataManager.share.imageURLs, !imageURLs.isEmpty,
            let imageURL = imageURLs.first,
            let url = URL(string: imageURL) {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let self = self, let data = data else {
                    return
                }

                DispatchQueue.main.async {
                    self.titleImageView.image = UIImage(data: data)
                }
            }
            task.resume()
        }

        titleLabel.text = CommonDataManager.share.itemForPost?.itemTitle
        nicknameLabel.text = CommonDataManager.share.userInfo?.userName
        minimumCountLabel.text = CommonDataManager.share.itemForPost?.itemAmountLimit
        endDateLabel.text = CommonDataManager.share.itemForPost?.tabOne?.endDate

        if let userId = CommonDataManager.share.userInfo?.userId {
            CommonDataManager.share.itemForPost?.userId = "\(userId)"
        }

        if let imageURLs = CommonDataManager.share.imageURLs {
            CommonDataManager.share.itemForPost?.imgPathList = imageURLs //["String"]
        }

        if let tabNumber = tabNumber {
            tabButtons[tabNumber].titleLabel?.textColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1)
                //.setTitleColor(#colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1), for: .normal)
            tabButtonSelectedViews[tabNumber].backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1)
            headerTabButtons[tabNumber].titleLabel?.textColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1) //.setTitleColor(#colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1), for: .normal)
             headerTabButtonSelectedViews[tabNumber].backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1)
        }
    }

    @IBAction private func actionPostItem(_ sender: UIButton) {
        do {
            let jsonEncoder = JSONEncoder()
            if let item = CommonDataManager.share.itemForPost,
            let data = try? jsonEncoder.encode(item),
            let params = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] {
                let path = "\(GrobyURL.base)\(GrobyURL.item.rawValue)"

                print(params)
                let requestData = RequestData(path: path, method: .post, params: params)

                CommonAPIManager.execute(requestData, onSuccess: { [weak self] _ in
                    guard let `self` = self else {
                        return
                    }

                   NotificationCenter.default.post(name: CommonTabViewController.addPostNotificationName, object: nil)
                    CommonDataManager.share.imageURLs = nil
                    self.dismiss(animated: true, completion: nil)

                }) { _ in
                    assertionFailure("ItemAPI Error")
                }
            }
        } catch let error {
            assertionFailure("JSONEncoder Error")
        }
    }
}

// MARK: -

extension MakeTab1FourthViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 532 {
            tabMenuView.isHidden = false
        } else {
            tabMenuView.isHidden = true
        }
        print("scrollViewDidScroll: \(scrollView.contentOffset.y)")
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 532 {
            tabMenuView.isHidden = false
        } else {
            tabMenuView.isHidden = true
        }
        print("scrollViewDidEndDecelerating: \(scrollView.contentOffset.y)")
    }

    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        navigationController?.navigationBar.isHidden = false
    }
}
