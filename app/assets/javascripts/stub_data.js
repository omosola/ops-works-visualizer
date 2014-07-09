var data = [{
  "stack_id": "02604520-900f-4e56-b553-0acf5798aa06",
  "name": "App: babbel-staging",
  "hostname": "Layer_Dependent",
  "default_os": "Ubuntu 12.04 LTS",
  "default_az": "eu-west-1c",
  "layers": [
    {
      "layer_id": "799bcb26-4758-4596-a9cb-aecbb721d078",
      "type": "rails-app",
      "name": "Rails App Server"
    },
    {
      "layer_id": "376cd5ce-25f0-4c5d-bfaf-23bf3b61a102",
      "type": "custom",
      "name": "Other Application Server"
    },
    {
      "layer_id": "f850e2f9-6284-4a43-9d85-b13ad7895fc5",
      "type": "custom",
      "name": "Rails Database Migrator"
    },
    {
      "layer_id": "58cabf0f-24d5-4e42-8a39-ff3832a2b5f4",
      "type": "custom",
      "name": "Rails Web Server"
    },
    {
      "layer_id": "1af49af1-1c99-4c52-92fa-4155758c8172",
      "type": "custom",
      "name": "Rails Worker"
    },
    {
      "layer_id": "963dc4c3-b720-4792-a041-c348a654abad",
      "type": "custom",
      "name": "Payment Proxy"
    }
  ],
  "instances": [
    {
      
    },
    {
      
    },
    {
      
    }
  ],
  "elbs": [
    {
      "elb_id": "58cabf0f-24d5-4e42-8a39-ff3832a2b5f4",
      "region": "eu-west-1",
      "availability_zones": null
    },
    {
      "elb_id": "963dc4c3-b720-4792-a041-c348a654abad",
      "region": "eu-west-1",
      "availability_zones": null
    }
  ]
},
{
  "stack_id": "685fda70-b5f8-4774-b534-df03b026ffdd",
  "name": "App: lp-staging",
  "hostname": "Layer_Dependent",
  "default_os": "Ubuntu 12.04 LTS",
  "default_az": "eu-west-1c",
  "layers": [
    {
      "layer_id": "aba13ca0-f93f-44f1-bb78-25ee5b900fbf",
      "type": "rails-app",
      "name": "Rails App Server"
    },
    {
      "layer_id": "6625bd55-ea64-4078-af9f-b90f66068400",
      "type": "custom",
      "name": "Rails Web Server"
    }
  ],
  "instances": [
    {
      
    },
    {
      
    }
  ],
  "elbs": [
    {
      "elb_id": "6625bd55-ea64-4078-af9f-b90f66068400",
      "region": "eu-west-1",
      "availability_zones": null
    }
  ]
},
{
  "stack_id": "f29c851a-9150-4860-98c3-854bcc78a54b",
  "name": "App: accounts-staging",
  "hostname": "Layer_Dependent",
  "default_os": "Ubuntu 12.04 LTS",
  "default_az": "eu-west-1b",
  "layers": [
    {
      "layer_id": "30362407-25ca-445e-bb78-a9afc0249b0e",
      "type": "rails-app",
      "name": "Rails App Server"
    },
    {
      "layer_id": "0bc66341-aa68-4988-804c-23b342c547a5",
      "type": "custom",
      "name": "Rails Web Server"
    },
    {
      "layer_id": "998fb7c9-a5e3-49d6-a75c-60d7f6f9fe6a",
      "type": "custom",
      "name": "Rails Worker"
    },
    {
      "layer_id": "c518cb2d-db79-4ed7-bb8e-363641e3bd79",
      "type": "custom",
      "name": "Rails Database Migrator"
    }
  ],
  "instances": [
    {
      
    },
    {
      
    }
  ],
  "elbs": [
    {
      "elb_id": "0bc66341-aa68-4988-804c-23b342c547a5",
      "region": "eu-west-1",
      "availability_zones": null
    }
  ]
},
{
  "stack_id": "4b1d0d81-a032-4573-a91c-41c1fa1c3b26",
  "name": "App: media-staging",
  "hostname": "Layer_Dependent",
  "default_os": "Ubuntu 12.04 LTS",
  "default_az": "eu-west-1b",
  "layers": [
    {
      "layer_id": "8ea352d1-4bf7-4e60-afd1-3d3db69c9b34",
      "type": "rails-app",
      "name": "Rails App Server"
    },
    {
      "layer_id": "a83c7020-d261-46a0-98bf-6dbe8d413d39",
      "type": "custom",
      "name": "Rails Web Server"
    },
    {
      "layer_id": "84fca28c-0419-4ab5-8b06-2a6cb0349970",
      "type": "custom",
      "name": "Rails Database Migrator"
    }
  ],
  "instances": [
    {
      
    },
    {
      
    }
  ],
  "elbs": [
    {
      "elb_id": "a83c7020-d261-46a0-98bf-6dbe8d413d39",
      "region": "eu-west-1",
      "availability_zones": null
    }
  ]
}];

