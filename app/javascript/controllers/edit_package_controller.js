import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("edit package controller connected!")
    this.inputs = this.element.querySelectorAll('input');
    this.textAreas = this.element.querySelectorAll('textarea'); // Target text_area elements
    this.saveButton = this.element.querySelector('.saveButton');
    this.editButton = this.element.querySelector('.editButton');
  }

  edit() {
    this.toggleEditState(false); // Set fields to editable
    this.saveButton.style.display = 'block';
    this.editButton.style.display = 'none';
  }

  save() {
    this.toggleEditState(true); // Set fields to readonly
    this.saveButton.style.display = 'none';
    this.editButton.style.display = 'block';
  }

  toggleEditState(readonly) {
    this.inputs.forEach(input => {
      input.readOnly = readonly;
      readonly ? input.classList.remove("form-control") : input.classList.add("form-control");
    });

    this.textAreas.forEach(textArea => {
      textArea.readOnly = readonly;
      readonly ? textArea.classList.remove("form-control") : textArea.classList.add("form-control");
    });
  }
}
