Prefix rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#>
Prefix rdfs:<http://www.w3.org/2000/01/rdf-schema#>
Prefix xsd:<http://www.w3.org/2001/XMLSchema#>
Prefix gr:<http://purl.org/goodrelations/v1#>
Prefix schema:<http://schema.org/>
Prefix dicom:<http://purl.org/healthcarevocab/v1#>
Prefix tns:<http://mycompany.com/datasets/>

Create View products As
    Construct {
        ?s a gr:BusinessEntity;
           a gr:BusinessEntity2;
           a gr:BusinessEntity3;
           schema:productID ?x0;
           dicom:ProductName ?x1.
    }
    With
        ?s = uri(concat('http://mycompany.com/datasets/', ?ProductID))
        ?x0 = typedLiteral(?ProductID, xsd:ID)
        ?x1 = typedLiteral(?ProductName, xsd:string)
    From products; 
