import UIKit

final class UserListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var model: [UserModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    weak var presenter: ViewToPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        UserListRouter.createUserListingVC(for: self)
        self.getUserList()
    }

    private func getUserList() {
        guard let page = presenter?.page else {
            return
        }
        presenter?.getUserList(for: page)
    }

    private func showErrorView(errorString: String) {
        print(errorString)
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.reusableID, for: indexPath) as? UserListTableViewCell else {
            return UITableViewCell()
        }

        let countOfObj = model.count
        if indexPath.row == countOfObj - 1 {
            guard let total = presenter?.total, let pageLimit = presenter?.pageLimit, let page = presenter?.page else {
                return UITableViewCell()
            }
            if  total > pageLimit * page {
                self.getUserList()
            }
        }

        guard !model.isEmpty else {
            return UITableViewCell()
        }
        let model = model[indexPath.row]
        cell.setData(userModel: model)
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

    func setData(userModel: UserModel) {
        label1.text = "Name: \(userModel.name ?? "NA")"
        label2.text = "Address: \(userModel.email ?? "NA")"
        label3.text = "Company: \(userModel.company?.name ?? "NA")"
        label4.text = "Address: \(userModel.address?.city ?? "NA")"
    }
}
extension UserListViewController: PresenterToView {
    func userList(result: Result<[UserModel], Error>) {

        switch result {
        case .success(let userModel):

            guard let page = presenter?.page else {
                return
            }
            let pageVal = page + 1
            presenter?.page = pageVal
            self.model.append(contentsOf: userModel)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
