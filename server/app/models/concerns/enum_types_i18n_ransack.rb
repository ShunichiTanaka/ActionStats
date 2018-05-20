module EnumTypesI18nRansack
  def enum_types_i18n_ransack(column)
    send(column.to_s.pluralize).map { |k, v| [send("#{column.to_s.pluralize}_i18n")[k], v] }
  end
end
