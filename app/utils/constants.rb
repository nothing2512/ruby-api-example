class Constants

  NIL_COMMAND = 0
  SELECT_COMMAND = 1
  UPDATE_COMMAND = 2
  DELETE_COMMAND = 3
  CREATE_COMMAND = 4
  PROCEDURE_COMMAND = 5

  IMAGE_DIR = Rails.root.join("public", "storage")

  SALT = "ApiTesting"
end