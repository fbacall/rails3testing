# So we can check permissions of not-logged-in users.
class NilClass

  def can?(action, object)
    false
  end

end