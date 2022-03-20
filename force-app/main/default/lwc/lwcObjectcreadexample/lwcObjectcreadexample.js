import { LightningElement, track } from 'lwc';

export default class LwcObjectcreadexample extends LightningElement {
            @track result;
            number1;
            number2;

            callme(event){
                const evtname= event.target.name;
                if(evtname==='aval'){
                    this.number1 = event.target.value;
                }
                else{
                    this.number2 = event.target.value;
                }
            }
            show(){
                const aval = parseInt(this.number1);
                const bval = parseInt(this.number2);
                this.result= +(aval + bval);
            }
        }