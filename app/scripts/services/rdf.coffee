'use strict'

angular.module 'app'
  .factory 'Rdf', ->

    baseUri: ''

    selectedClasses : {}
    selectedProperties : {}

    # selectedClasses : {
    #   "products":[
    #     {
    #       "definition":[],
    #       "prefixedName":["gr:BusinessEntity"],
    #       "vocabulary.description":[],
    #       "vocabulary.title":[],
    #       "vocabulary.uri":["http://purl.org/goodrelations/v1#"],
    #       "localName":["BusinessEntity"],
    #       "label":["Business entity"],
    #       "score":0.40066153,
    #       "comment":["An instance of this class represents the legal agent making (or seeking) a particular offering. This can be a legal body or a person. A business entity has at least a primary mailing address and contact details. For this, typical address standards (vCard) and location data (geo, WGS84) can be attached. Note that the location of the business entity is not necessarily the location from which the product or service is being available (e.g. the branch or store). Use gr:Location for stores and branches.\n\t\t\nExample: Siemens Austria AG, Volkswagen Ltd., Peter Miller's Cell phone Shop LLC\n\nCompatibility with schema.org: This class is equivalent to the union of http://schema.org/Person and http://schema.org/Organization."],
    #       "vocabulary.prefix":["gr"],
    #       "uri":["http://purl.org/goodrelations/v1#BusinessEntity"]
    #     }
    #   ]
    # }
    # selectedProperties : {
    #   "products":{
    #     "ProductID":{
    #       "definition":[],
    #       "prefixedName":["schema:productID"],
    #       "vocabulary.description":["Search engines including Bing, Google, Yahoo! and Yandex rely on schema.org markup to improve the display of search results, making it easier for people to find the right web pages."],
    #       "vocabulary.title":["Schema.org vocabulary"],
    #       "vocabulary.uri":["http://schema.org/"],
    #       "localName":["productID"],
    #       "label":["productID"],
    #       "score":1,
    #       "comment":["The product identifier, such as ISBN. For example: <code>&lt;meta itemprop='productID' content='isbn:123-456-789'/&gt;</code>."],
    #       "vocabulary.prefix":["schema"],"uri":["http://schema.org/productID"]
    #     },
    #     "ProductName":{
    #       "definition":[],
    #       "prefixedName":["dicom:ProductName"],
    #       "vocabulary.description":[],
    #       "vocabulary.title":[],
    #       "vocabulary.uri":["http://purl.org/healthcarevocab/v1#"],
    #       "localName":["ProductName"],
    #       "label":["Product Name"],
    #       "score":1,"comment":[],
    #       "vocabulary.prefix":["dicom"],
    #       "uri":["http://purl.org/healthcarevocab/v1#ProductName"]
    #     }
    #   }
    # }
