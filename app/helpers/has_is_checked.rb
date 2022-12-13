module HasIsChecked
  def checked_message(instance)
    if instance.is_checked?
      tag.div "確認済み", class: "text-success font-weight-bold"
    else
      tag.div "未確認", class: "text-danger font-weight-bold"
    end
  end

  #def published_message(job)
  #  text, class_name = job.is_published? ? ["公開", "text-success"] : ["未公開", "text-danger"]
  #  tag.div text, class: "#{class_name} font-weight-bold"
  #end
end