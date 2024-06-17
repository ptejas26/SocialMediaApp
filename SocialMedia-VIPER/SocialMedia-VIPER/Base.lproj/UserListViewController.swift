import UIKit

final class UserListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: UserListViewModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        viewModel = UserListViewModel()
        getUserList()
    }

    func getUserList() {
        viewModel?.getUserList(completionHandler: { [weak self] result in
            guard let self else {
                return
            }
            switch result {
            case .success():
                self.viewModel?.page += 1
                self.tableView.reloadData()
            case .failure(let error):
                self.showErrorView(errorString: error.localizedDescription)
            }
        })
    }

    private func showErrorView(errorString: String) {
        print(errorString)
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.model.count ?? 0
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.reusableID, for: indexPath) as? UserListTableViewCell else {
            return UITableViewCell()
        }

        guard let page = viewModel?.page, let pageLimit = viewModel?.pageLimit, let total = viewModel?.total, let countOfObj = self.viewModel?.model.count else {
            return UITableViewCell()
        }
            // && total > (page * pageLimit)
        if indexPath.row == countOfObj - 1 {
            if total > (pageLimit * page) {
                print("Call pagination API")
                self.getUserList()
            }
        }

        guard let viewModel else {
            return UITableViewCell()
        }
        cell.setData(viewModel: viewModel, row: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

final class UserListTableViewCell: UITableViewCell {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!

    static let reusableID = String(describing: UserListTableViewCell.self)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setData(viewModel: UserListViewModel, row: Int) {
        label1.text = "Name: \(viewModel.getName(for: row))"
        label2.text = "Address: \(viewModel.getEmailAddress(for: row))"
        label3.text = "Company: \(viewModel.getCompanyName(for: row))"
        label4.text = "Address: \(viewModel.getAddress(for: row))"
    }
}
