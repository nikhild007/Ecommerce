module HomeHelper
    def user_initials(user)
        initials = user.email.split("@")[0][0,2]
        content_tag(:span, initials, class: "user-initials")
    end
end
