# Microsoft Foundry Agent APIM Connection

## Introduction
This capability enables organizations to maintain control over their model endpoints. Keep your model endpoints secure behind your existing APIM Gateway by applying security policies. It is also be useful when Azure OpenAI PTU models are shared across multiple subscriptions.

## Setup Steps
1.	Create a Foundry API in APIM and keep a note of API Name using
https://learn.microsoft.com/en-us/azure/api-management/azure-ai-foundry-api
<img width="1510" height="823" alt="image" src="https://github.com/user-attachments/assets/f9f08a5d-8741-44fd-8014-5a4f221a15b1" />

2a. If you are using Bicep, Clone repo : https://github.com/azure-ai-foundry/foundry-samples/tree/main/infrastructure/infrastructure-setup-bicep/01-connections/apim
    - Copy samples/parameters-static-models.json and edit the parameters
      
        - **projectResourceId** : Enter Foundry Project Resource Id 
          
          <img width="1888" height="408" alt="image" src="https://github.com/user-attachments/assets/d951aa86-bc58-45f7-8424-26c8b10675f6" />


        - **apimResourceId** : Enter APIM Resource Id
          
          <img width="1866" height="331" alt="image" src="https://github.com/user-attachments/assets/1855bde9-0d38-4c62-8fe1-a16f7b1e3a08" />


        - **apiName** : Enter Foundry API name from Step 1
          
        - **connectionName** : Give connection name which will be created as connection in Foundry Project
          
        - Under “Static” model sections list the models in foundry project and set format as “OpenAI” **(Use New Foundry View)**

          <img width="1886" height="299" alt="image" src="https://github.com/user-attachments/assets/60106050-4d2c-4460-b7b6-ed4dc12c45b2" />

          <img width="575" height="396" alt="image" src="https://github.com/user-attachments/assets/cc6cceea-866e-4891-aabe-da5be9e550cb" />

        - Run in command line
        ```bash
        az deployment group create --resource-group [Resource Group] --template-file connection-apim.bicep --parameters @samples/parameters-static-models-foundry.json
        ```

2b. If you are using Terraform, [Min to include]

3. 
