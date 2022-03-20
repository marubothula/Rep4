import { LightningElement, track,wire } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
export default class LdsCreateRecord extends LightningElement {
    @track name;
    @track phone;
    @track industry;
    @track rating;

    Accname(event){
            this.name = event.target.value;
    }
    Accphone(event){
        this.phone = event.target.value;

    }

    Accindustry(event){
    this.industry = event.target.value;

    }

    Accrating(event){
    this.rating = event.target.value;
    }

    show(){
        const fields = {'Name':this.name, 'Phone':this.phone, 'Industry' :this.industry, 'Rating':this.rating};
        const recordData = {apiName:'Account',fields};
        createRecord(recordData).then(response=>{
            console.log('Account record created:'+response.id);
        }).catch(error=>{
            console.log('Error:' +error.body.message);
        });
    }

}