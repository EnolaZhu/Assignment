//
//  ViewController.swift
//  Assignment of Glossika
//
//  Created by enola.zhu on 2024/9/20.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let tableViewIdentifier = "tableViewIdentifier"
    private let rowHeight = 200.0
    private var viewModel: MainPageViewModel!
    private var cancellables = Set<AnyCancellable>()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    let dataSource: [[UIImage]] = [
        [UIImage(named: "image1")!, UIImage(named: "image2")!, UIImage(named: "image1")!, UIImage(named: "image1")!, UIImage(named: "image1")!, UIImage(named: "image1")!],
        [UIImage(named: "image1")!, UIImage(named: "image1")!, UIImage(named: "image1")!],
        [UIImage(named: "image2")!, UIImage(named: "image2")!, UIImage(named: "image2")!]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()

        viewModel = MainPageViewModel(getDataUseCase: FetchMainPageDataRemoteUseCase())
        bindViewModel()
        fetchAssets()
    }

    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.separatorStyle = .none
        tableView.register(TableViewCell.self, forCellReuseIdentifier: tableViewIdentifier)
    }

    private func bindViewModel() {
        viewModel.$assetSets
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    self?.tableView.isHidden = true
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.tableView.isHidden = false
                }
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                if let errorMessage = errorMessage {
                    self?.showAlert(with: errorMessage)
                }
            }
            .store(in: &cancellables)
    }

    private func fetchAssets() {
        Task {
            await viewModel.fetchMainPageAssets()
        }
    }

    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.assetSets.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rowHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewIdentifier, for: indexPath) as! TableViewCell
        cell.selectionStyle = .none
        cell.configure(with: dataSource[indexPath.section])
        return cell
    }
}
