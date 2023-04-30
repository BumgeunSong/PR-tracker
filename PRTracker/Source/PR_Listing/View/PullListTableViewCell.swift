//
//  PullListTableViewCell.swift
//  PRTracker
//
//  Created by 안상희 on 2022/06/17.
//

import UIKit

class PullListTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var milestone: UILabel!
    @IBOutlet weak var state: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with viewModel: IssueTableCellViewModel) {
        title.text = viewModel.title.value
        content.text = viewModel.content.value
        projectName.text = viewModel.projectName.value
        milestone.text = viewModel.labelList.value?.first?.name.value
        state.text = viewModel.state.value
    }
}
