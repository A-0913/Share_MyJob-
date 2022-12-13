module HasIsChecked
  def checked_message(instance)
    if instance.is_checked?
      tag.div "確認済み", class: "text-success font-weight-bold"
    else
      tag.div "未確認", class: "text-danger font-weight-bold"
    end
  end
end