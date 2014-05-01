class UserEventSlugValidator < ActiveModel::Validator
  def validate(record)

    if record.slug.present? && (ele = Event.incoming.where(slug: record.slug).first || User.where(nickname: record.slug).first)
      record.errors.add :nickname, :taken if record.is_a?(User) && ele != record
      record.errors.add :slug, :taken if record.is_a?(Event) && ele != record
    end
  end
end
