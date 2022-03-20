import { LightningElement } from 'lwc';

export default class Lwc_example2 extends LightningElement {
    greeting = 'World';
    changeHandler(event) {
      this.greeting = event.target.value;
}
}