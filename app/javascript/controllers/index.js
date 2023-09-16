import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import InsertInListController from "./insert_in_list_controller"
application.register("insert-in-list", InsertInListController)

import ToggleController from "./toggle_controller"
application.register("toggle", ToggleController)
