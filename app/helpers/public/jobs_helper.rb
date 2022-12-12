module Public::JobsHelper
  def published_message(job)
    if job.is_published?
      tag.div "公開", class: "text-success font-weight-bold"
    else
      tag.div "未公開", class: "text-danger font-weight-bold"
    end
  end
end
