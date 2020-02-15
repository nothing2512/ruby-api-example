class UserModel < Connection

  def all
    execute "SELECT * FROM `person`"
  end

  def insert(name, email, password, address, photo)
    execute "INSERT INTO `person` VALUES (null, '%s', '%s', '%s', '%s', '%s')",
            name, email, password, address, photo
    single "SELECT * FROM `person` WHERE personId = %s", last_insert_id
  end

  def detail(id: 0, email: "")
    single "SELECT * FROM `person` WHERE `personId` = %i OR email = '%s'", id, email
  end
end