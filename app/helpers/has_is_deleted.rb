module HasIsDeleted
  def deleted_message(instance)
    if instance.is_deleted?
      tag.div "退会", class: "text-danger font-weight-bold"
    else
      tag.div "有効", class: "text-success font-weight-bold"
    end
  end

  #def published_message(job)
  #  text, class_name = job.is_published? ? ["公開", "text-success"] : ["未公開", "text-danger"]
  #  tag.div text, class: "#{class_name} font-weight-bold"
  #end
end
