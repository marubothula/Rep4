import { LightningElement } from 'lwc';

export default class Institute extends LightningElement {
    course_details = [{'name':'SFDC Admin','duration': '30days','fee':3000},
                      {'name':'SFDC dev','duration': '40days','fee':4000},
                      {'name':'SFDC Light','duration': '50days','fee':5000},
                      {'name':'SFDC Integration','duration': '60days','fee':6000}
                    ];
}