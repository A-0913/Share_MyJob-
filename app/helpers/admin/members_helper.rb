module Admin::MembersHelper
  include HasIsPublished
  include HasIsChecked
  include HasContact

  def deleted_message(instance)
    if instance.is_deleted?
      tag.div "退会", class: "text-danger font-weight-bold"
    else
      tag.div "有効", class: "text-success font-weight-bold"
    end
  end
end
