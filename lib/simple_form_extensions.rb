module WrappedButton
  def wrapped_button(*args, &block)
    template.content_tag :div, :class => "form-actions" do
      options = args.extract_options!
      loading = self.object.new_record? ? I18n.t('simple_form.creating') : I18n.t('simple_form.updating')
      options[:"data-loading-text"] = [loading, options[:"data-loading-text"]].compact
      options[:class] = ['btn btn-primary', options[:class]].compact
      args << options
      if cancel = options.delete(:cancel)
        if cancel == "close-modal"
          template.link_to(I18n.t('simple_form.buttons.cancel'), "#", { "data-dismiss" => "modal", "aria-hidden" => "true", class: 'btn' }) + ' - ' +
            "<span class='or'>#{I18n.t('simple_form.buttons.or')}</span>".html_safe + ' - ' +
            submit(*args, &block)

        else
          template.link_to(I18n.t('simple_form.buttons.cancel'), cancel, class: 'btn') +' - ' +
            "<span class='or'>#{I18n.t('simple_form.buttons.or')}</span>".html_safe + ' - ' + submit(*args, &block)

        end
      else
        submit(*args, &block)
      end
    end
  end
end
SimpleForm::FormBuilder.send :include, WrappedButton
