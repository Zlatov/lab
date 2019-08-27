exit

# destroy выполняет любые обратные вызовы модели, а delete - нет
Model.find(1).destroy
Model.find_by(col: "foo").destroy_all

Model.find_by_name("foo").delete
Model.where(col: "foo").delete_all
