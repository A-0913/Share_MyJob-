module HasContact
  def contact_message(instance)
    if instance.contact.blank?
      tag.div "連絡事項はありません。", class: "text-info font-weight-bold"
    else
      instance.contact
    end
  end
end
