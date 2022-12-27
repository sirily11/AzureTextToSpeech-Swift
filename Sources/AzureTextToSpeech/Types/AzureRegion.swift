//
//  File.swift
//
//
//  Created by Qiwei Li on 12/26/22.
//

import Foundation

public enum AzureRegion: String, CaseIterable, Identifiable {
    case southAfricanNorth = "southafricanorth"
    case eastAsia = "eastasia"
    case southeastAsia = "southeastasia"
    case australiaEast = "australiaeast"
    case centralIndia = "centralindia"
    case japanEast = "japaneast"
    case japanWest = "japanwest"
    case koreaCentral = "koreacentral"
    case canadaCentral = "canadacentral"
    case northEurope = "northeurope"
    case westEurope = "westeurope"
    case franceCentral = "francecentral"
    case germanyWestCentral = "germanywestcentral"
    case norwayEast = "norwayeast"
    case switzerlandNorth = "switzerlandnorth"
    case switzerlandWest = "switzerlandwest"
    case ukSouth = "uksouth"
    case uaeNorth = "uaenorth"
    case brazilSouth = "brazilsouth"
    case centralUS = "centralus"
    case eastUS = "eastus"
    case eastUS2 = "eastus2"
    case northCentralUS = "northcentralus"
    case southCentralUS = "southcentralus"
    case westCentralUS = "westcentralus"
    case westUS = "westus"
    case westUS2 = "westus2"
    case westUS3 = "westus3"

    public var id: Self { self }
}
