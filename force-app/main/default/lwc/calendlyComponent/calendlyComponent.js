import { LightningElement,api } from 'lwc';

export default class CalendlyComponent extends LightningElement {

    @api calendlyURL;



    connectedCallback(){

        console.log(calendlyURL);
    }



}