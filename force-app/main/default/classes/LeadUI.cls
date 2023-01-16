public with sharing class LeadUI {
    public LeadUI() {
        System.debug('This is Constructor Method');
    }
    @AuraEnabled
    public static string create(Lead singleLead, Ad__c singleAd){
        
        List<Campaign> singleCampaign = New List<Campaign>();
        CampaignMember singleCampaignMember = New CampaignMember(); 
        String searchCampaign = '%' + singleAd.UTM_Source__c + '%';
        String result;
        
        
        try {
            singleCampaign = [SELECT Id,Name,IsActive FROM Campaign
                              WHERE Name LIKE :searchCampaign AND IsActive=True 
                              LIMIT 1];
            if(singleCampaign.size()==0){
                //No Campaign Record
                System.debug(searchCampaign + ' campaign is inactive');
                insert singleAd;

                singleLead.Ad__c = singleAd.Id;
                insert singleLead;
            }else{
                System.debug(searchCampaign + ' campaign is active');
                singleAd.Campaign__c = singleCampaign.get(0).Id;
                insert singleAd;

                singleLead.Ad__c = singLeAd.Id;
                insert singlead;

                singleCampaignMember.CampaignId = singleCampaign.get(0).Id;
                singleCampaignMember.LeadId = singleLead.Id;
                singleCampaignMember.Status = 'Received';
                
                insert singleCampaignMember;

            }
            
            result = 'Succesfullu Created';
            
            
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }

        return result;
    }
}
