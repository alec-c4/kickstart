module FlashHelper
  def flash_class(level)
    case level
    when "notice"
      "alert alert-info"
    when "success"
      "alert alert-success"
    when "error"
      "alert alert-danger"
    when "alert"
      "alert alert-warning"
    end
  end
end
