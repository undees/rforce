require 'xsd/qname'

# {urn:partner.soap.sforce.com}login
class Login
  @@schema_type = "login"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["username", "SOAP::SOAPString"], ["password", "SOAP::SOAPString"]]

  attr_accessor :username
  attr_accessor :password

  def initialize(username = nil, password = nil)
    @username = username
    @password = password
  end
end

# {urn:partner.soap.sforce.com}loginResponse
class LoginResponse
  @@schema_type = "loginResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "LoginResult"]]

  attr_accessor :result

  def initialize(result = nil)
    @result = result
  end
end

# {urn:partner.soap.sforce.com}describeSObject
class DescribeSObject
  @@schema_type = "describeSObject"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["sObjectType", "SOAP::SOAPString"]]

  attr_accessor :sObjectType

  def initialize(sObjectType = nil)
    @sObjectType = sObjectType
  end
end

# {urn:partner.soap.sforce.com}describeSObjectResponse
class DescribeSObjectResponse
  @@schema_type = "describeSObjectResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "DescribeSObjectResult"]]

  attr_accessor :result

  def initialize(result = nil)
    @result = result
  end
end

# {urn:partner.soap.sforce.com}describeSObjects
class DescribeSObjects
  @@schema_type = "describeSObjects"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["sObjectType", "SOAP::SOAPString[]"]]

  attr_accessor :sObjectType

  def initialize(sObjectType = [])
    @sObjectType = sObjectType
  end
end

# {urn:partner.soap.sforce.com}describeSObjectsResponse
class DescribeSObjectsResponse
  @@schema_type = "describeSObjectsResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "DescribeSObjectResult[]"]]

  attr_accessor :result

  def initialize(result = [])
    @result = result
  end
end

# {urn:partner.soap.sforce.com}describeGlobal
class DescribeGlobal
  @@schema_type = "describeGlobal"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = []

  def initialize
  end
end

# {urn:partner.soap.sforce.com}describeGlobalResponse
class DescribeGlobalResponse
  @@schema_type = "describeGlobalResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "DescribeGlobalResult"]]

  attr_accessor :result

  def initialize(result = nil)
    @result = result
  end
end

# {urn:partner.soap.sforce.com}describeLayout
class DescribeLayout
  @@schema_type = "describeLayout"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["sObjectType", "SOAP::SOAPString"]]

  attr_accessor :sObjectType

  def initialize(sObjectType = nil)
    @sObjectType = sObjectType
  end
end

# {urn:partner.soap.sforce.com}describeLayoutResponse
class DescribeLayoutResponse
  @@schema_type = "describeLayoutResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "DescribeLayoutResult"]]

  attr_accessor :result

  def initialize(result = nil)
    @result = result
  end
end

# {urn:partner.soap.sforce.com}describeTabs
class DescribeTabs
  @@schema_type = "describeTabs"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = []

  def initialize
  end
end

# {urn:partner.soap.sforce.com}describeTabsResponse
class DescribeTabsResponse
  @@schema_type = "describeTabsResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "DescribeTabSetResult[]"]]

  attr_accessor :result

  def initialize(result = [])
    @result = result
  end
end

# {urn:partner.soap.sforce.com}create
class Create
  @@schema_type = "create"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["sObjects", "SObject[]"]]

  attr_accessor :sObjects

  def initialize(sObjects = [])
    @sObjects = sObjects
  end
end

# {urn:partner.soap.sforce.com}createResponse
class CreateResponse
  @@schema_type = "createResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "SaveResult[]"]]

  attr_accessor :result

  def initialize(result = [])
    @result = result
  end
end

# {urn:partner.soap.sforce.com}update
class Update
  @@schema_type = "update"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["sObjects", "SObject[]"]]

  attr_accessor :sObjects

  def initialize(sObjects = [])
    @sObjects = sObjects
  end
end

# {urn:partner.soap.sforce.com}updateResponse
class UpdateResponse
  @@schema_type = "updateResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "SaveResult[]"]]

  attr_accessor :result

  def initialize(result = [])
    @result = result
  end
end

# {urn:partner.soap.sforce.com}delete
class Delete
  @@schema_type = "delete"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["ids", "SOAP::SOAPString[]"]]

  attr_accessor :ids

  def initialize(ids = [])
    @ids = ids
  end
end

# {urn:partner.soap.sforce.com}deleteResponse
class DeleteResponse
  @@schema_type = "deleteResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "DeleteResult[]"]]

  attr_accessor :result

  def initialize(result = [])
    @result = result
  end
end

# {urn:partner.soap.sforce.com}retrieve
class Retrieve
  @@schema_type = "retrieve"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["fieldList", "SOAP::SOAPString"], ["sObjectType", "SOAP::SOAPString"], ["ids", "SOAP::SOAPString[]"]]

  attr_accessor :fieldList
  attr_accessor :sObjectType
  attr_accessor :ids

  def initialize(fieldList = nil, sObjectType = nil, ids = [])
    @fieldList = fieldList
    @sObjectType = sObjectType
    @ids = ids
  end
end

# {urn:partner.soap.sforce.com}retrieveResponse
class RetrieveResponse
  @@schema_type = "retrieveResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "SObject[]"]]

  attr_accessor :result

  def initialize(result = [])
    @result = result
  end
end

# {urn:partner.soap.sforce.com}convertLead
class ConvertLead
  @@schema_type = "convertLead"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["leadConverts", "LeadConvert[]"]]

  attr_accessor :leadConverts

  def initialize(leadConverts = [])
    @leadConverts = leadConverts
  end
end

# {urn:partner.soap.sforce.com}convertLeadResponse
class ConvertLeadResponse
  @@schema_type = "convertLeadResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "LeadConvertResult[]"]]

  attr_accessor :result

  def initialize(result = [])
    @result = result
  end
end

# {urn:partner.soap.sforce.com}getUpdated
class GetUpdated
  @@schema_type = "getUpdated"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["sObjectType", "SOAP::SOAPString"], ["startDate", "SOAP::SOAPDateTime"], ["endDate", "SOAP::SOAPDateTime"]]

  attr_accessor :sObjectType
  attr_accessor :startDate
  attr_accessor :endDate

  def initialize(sObjectType = nil, startDate = nil, endDate = nil)
    @sObjectType = sObjectType
    @startDate = startDate
    @endDate = endDate
  end
end

# {urn:partner.soap.sforce.com}getUpdatedResponse
class GetUpdatedResponse
  @@schema_type = "getUpdatedResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "GetUpdatedResult"]]

  attr_accessor :result

  def initialize(result = nil)
    @result = result
  end
end

# {urn:partner.soap.sforce.com}getDeleted
class GetDeleted
  @@schema_type = "getDeleted"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["sObjectType", "SOAP::SOAPString"], ["startDate", "SOAP::SOAPDateTime"], ["endDate", "SOAP::SOAPDateTime"]]

  attr_accessor :sObjectType
  attr_accessor :startDate
  attr_accessor :endDate

  def initialize(sObjectType = nil, startDate = nil, endDate = nil)
    @sObjectType = sObjectType
    @startDate = startDate
    @endDate = endDate
  end
end

# {urn:partner.soap.sforce.com}getDeletedResponse
class GetDeletedResponse
  @@schema_type = "getDeletedResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "GetDeletedResult"]]

  attr_accessor :result

  def initialize(result = nil)
    @result = result
  end
end

# {urn:partner.soap.sforce.com}query
class Query
  @@schema_type = "query"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["queryString", "SOAP::SOAPString"]]

  attr_accessor :queryString

  def initialize(queryString = nil)
    @queryString = queryString
  end
end

# {urn:partner.soap.sforce.com}queryResponse
class QueryResponse
  @@schema_type = "queryResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "QueryResult"]]

  attr_accessor :result

  def initialize(result = nil)
    @result = result
  end
end

# {urn:partner.soap.sforce.com}queryMore
class QueryMore
  @@schema_type = "queryMore"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["queryLocator", "SOAP::SOAPString"]]

  attr_accessor :queryLocator

  def initialize(queryLocator = nil)
    @queryLocator = queryLocator
  end
end

# {urn:partner.soap.sforce.com}queryMoreResponse
class QueryMoreResponse
  @@schema_type = "queryMoreResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "QueryResult"]]

  attr_accessor :result

  def initialize(result = nil)
    @result = result
  end
end

# {urn:partner.soap.sforce.com}search
class Search
  @@schema_type = "search"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["searchString", "SOAP::SOAPString"]]

  attr_accessor :searchString

  def initialize(searchString = nil)
    @searchString = searchString
  end
end

# {urn:partner.soap.sforce.com}searchResponse
class SearchResponse
  @@schema_type = "searchResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "SearchResult"]]

  attr_accessor :result

  def initialize(result = nil)
    @result = result
  end
end

# {urn:partner.soap.sforce.com}getServerTimestamp
class GetServerTimestamp
  @@schema_type = "getServerTimestamp"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = []

  def initialize
  end
end

# {urn:partner.soap.sforce.com}getServerTimestampResponse
class GetServerTimestampResponse
  @@schema_type = "getServerTimestampResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "GetServerTimestampResult"]]

  attr_accessor :result

  def initialize(result = nil)
    @result = result
  end
end

# {urn:partner.soap.sforce.com}setPassword
class SetPassword
  @@schema_type = "setPassword"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["userId", "SOAP::SOAPString"], ["password", "SOAP::SOAPString"]]

  attr_accessor :userId
  attr_accessor :password

  def initialize(userId = nil, password = nil)
    @userId = userId
    @password = password
  end
end

# {urn:partner.soap.sforce.com}setPasswordResponse
class SetPasswordResponse
  @@schema_type = "setPasswordResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "SetPasswordResult"]]

  attr_accessor :result

  def initialize(result = nil)
    @result = result
  end
end

# {urn:partner.soap.sforce.com}resetPassword
class ResetPassword
  @@schema_type = "resetPassword"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["userId", "SOAP::SOAPString"]]

  attr_accessor :userId

  def initialize(userId = nil)
    @userId = userId
  end
end

# {urn:partner.soap.sforce.com}resetPasswordResponse
class ResetPasswordResponse
  @@schema_type = "resetPasswordResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "ResetPasswordResult"]]

  attr_accessor :result

  def initialize(result = nil)
    @result = result
  end
end

# {urn:partner.soap.sforce.com}getUserInfo
class GetUserInfo
  @@schema_type = "getUserInfo"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = []

  def initialize
  end
end

# {urn:partner.soap.sforce.com}getUserInfoResponse
class GetUserInfoResponse
  @@schema_type = "getUserInfoResponse"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["result", "GetUserInfoResult"]]

  attr_accessor :result

  def initialize(result = nil)
    @result = result
  end
end

# {urn:partner.soap.sforce.com}SessionHeader
class SessionHeader
  @@schema_type = "SessionHeader"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["sessionId", "SOAP::SOAPString"]]

  attr_accessor :sessionId

  def initialize(sessionId = nil)
    @sessionId = sessionId
  end
end

# {urn:partner.soap.sforce.com}CallOptions
class CallOptions
  @@schema_type = "CallOptions"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["client", "SOAP::SOAPString"]]

  attr_accessor :client

  def initialize(client = nil)
    @client = client
  end
end

# {urn:partner.soap.sforce.com}QueryOptions
class QueryOptions
  @@schema_type = "QueryOptions"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["batchSize", "SOAP::SOAPInt"]]

  attr_accessor :batchSize

  def initialize(batchSize = nil)
    @batchSize = batchSize
  end
end

# {urn:partner.soap.sforce.com}AssignmentRuleHeader
class AssignmentRuleHeader
  @@schema_type = "AssignmentRuleHeader"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_qualified = "true"
  @@schema_element = [["assignmentRuleId", "SOAP::SOAPString"], ["useDefaultRule", "SOAP::SOAPBoolean"]]

  attr_accessor :assignmentRuleId
  attr_accessor :useDefaultRule

  def initialize(assignmentRuleId = nil, useDefaultRule = nil)
    @assignmentRuleId = assignmentRuleId
    @useDefaultRule = useDefaultRule
  end
end

# {urn:sobject.partner.soap.sforce.com}sObject
class SObject
  @@schema_type = "sObject"
  @@schema_ns = "urn:sobject.partner.soap.sforce.com"
  @@schema_element = [["type", "SOAP::SOAPString"], ["fieldsToNull", "SOAP::SOAPString[]"], ["id", ["SOAP::SOAPString", XSD::QName.new("urn:sobject.partner.soap.sforce.com", "Id")]], ["any", [nil, XSD::QName.new(nil, "any")]]]

  attr_accessor :type
  attr_accessor :fieldsToNull
  attr_accessor :any

  def Id
    @id
  end

  def Id=(value)
    @id = value
  end

  def initialize(type = nil, fieldsToNull = [], id = nil, any = nil)
    @type = type
    @fieldsToNull = fieldsToNull
    @id = id
    @any = any
  end
end

# {urn:partner.soap.sforce.com}QueryResult
class QueryResult
  @@schema_type = "QueryResult"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["done", "SOAP::SOAPBoolean"], ["queryLocator", "SOAP::SOAPString"], ["records", "SObject[]"], ["size", "SOAP::SOAPInt"]]

  attr_accessor :done
  attr_accessor :queryLocator
  attr_accessor :records
  attr_accessor :size

  def initialize(done = nil, queryLocator = nil, records = [], size = nil)
    @done = done
    @queryLocator = queryLocator
    @records = records
    @size = size
  end
end

# {urn:partner.soap.sforce.com}SearchResult
class SearchResult
  @@schema_type = "SearchResult"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["searchRecords", "SearchRecord[]"], ["sforceReserved", "SOAP::SOAPString"]]

  attr_accessor :searchRecords
  attr_accessor :sforceReserved

  def initialize(searchRecords = [], sforceReserved = nil)
    @searchRecords = searchRecords
    @sforceReserved = sforceReserved
  end
end

# {urn:partner.soap.sforce.com}SearchRecord
class SearchRecord
  @@schema_type = "SearchRecord"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["record", "SObject"]]

  attr_accessor :record

  def initialize(record = nil)
    @record = record
  end
end

# {urn:partner.soap.sforce.com}GetUpdatedResult
class GetUpdatedResult
  @@schema_type = "GetUpdatedResult"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["ids", "SOAP::SOAPString[]"], ["sforceReserved", "SOAP::SOAPString"]]

  attr_accessor :ids
  attr_accessor :sforceReserved

  def initialize(ids = [], sforceReserved = nil)
    @ids = ids
    @sforceReserved = sforceReserved
  end
end

# {urn:partner.soap.sforce.com}GetDeletedResult
class GetDeletedResult
  @@schema_type = "GetDeletedResult"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["deletedRecords", "DeletedRecord[]"], ["sforceReserved", "SOAP::SOAPString"]]

  attr_accessor :deletedRecords
  attr_accessor :sforceReserved

  def initialize(deletedRecords = [], sforceReserved = nil)
    @deletedRecords = deletedRecords
    @sforceReserved = sforceReserved
  end
end

# {urn:partner.soap.sforce.com}DeletedRecord
class DeletedRecord
  @@schema_type = "DeletedRecord"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["deletedDate", "SOAP::SOAPDateTime"], ["id", "SOAP::SOAPString"]]

  attr_accessor :deletedDate
  attr_accessor :id

  def initialize(deletedDate = nil, id = nil)
    @deletedDate = deletedDate
    @id = id
  end
end

# {urn:partner.soap.sforce.com}GetServerTimestampResult
class GetServerTimestampResult
  @@schema_type = "GetServerTimestampResult"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["timestamp", "SOAP::SOAPDateTime"]]

  attr_accessor :timestamp

  def initialize(timestamp = nil)
    @timestamp = timestamp
  end
end

# {urn:partner.soap.sforce.com}SetPasswordResult
class SetPasswordResult
  @@schema_type = "SetPasswordResult"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = []

  def initialize
  end
end

# {urn:partner.soap.sforce.com}ResetPasswordResult
class ResetPasswordResult
  @@schema_type = "ResetPasswordResult"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["password", "SOAP::SOAPString"]]

  attr_accessor :password

  def initialize(password = nil)
    @password = password
  end
end

# {urn:partner.soap.sforce.com}GetUserInfoResult
class GetUserInfoResult
  @@schema_type = "GetUserInfoResult"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["currencySymbol", "SOAP::SOAPString"], ["organizationId", "SOAP::SOAPString"], ["organizationMultiCurrency", "SOAP::SOAPBoolean"], ["organizationName", "SOAP::SOAPString"], ["userDefaultCurrencyIsoCode", "SOAP::SOAPString"], ["userEmail", "SOAP::SOAPString"], ["userFullName", "SOAP::SOAPString"], ["userId", "SOAP::SOAPString"], ["userLanguage", "SOAP::SOAPString"], ["userLocale", "SOAP::SOAPString"], ["userTimeZone", "SOAP::SOAPString"]]

  attr_accessor :currencySymbol
  attr_accessor :organizationId
  attr_accessor :organizationMultiCurrency
  attr_accessor :organizationName
  attr_accessor :userDefaultCurrencyIsoCode
  attr_accessor :userEmail
  attr_accessor :userFullName
  attr_accessor :userId
  attr_accessor :userLanguage
  attr_accessor :userLocale
  attr_accessor :userTimeZone

  def initialize(currencySymbol = nil, organizationId = nil, organizationMultiCurrency = nil, organizationName = nil, userDefaultCurrencyIsoCode = nil, userEmail = nil, userFullName = nil, userId = nil, userLanguage = nil, userLocale = nil, userTimeZone = nil)
    @currencySymbol = currencySymbol
    @organizationId = organizationId
    @organizationMultiCurrency = organizationMultiCurrency
    @organizationName = organizationName
    @userDefaultCurrencyIsoCode = userDefaultCurrencyIsoCode
    @userEmail = userEmail
    @userFullName = userFullName
    @userId = userId
    @userLanguage = userLanguage
    @userLocale = userLocale
    @userTimeZone = userTimeZone
  end
end

# {urn:partner.soap.sforce.com}LoginResult
class LoginResult
  @@schema_type = "LoginResult"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["passwordExpired", "SOAP::SOAPBoolean"], ["serverUrl", "SOAP::SOAPString"], ["sessionId", "SOAP::SOAPString"], ["userId", "SOAP::SOAPString"], ["userInfo", "GetUserInfoResult"]]

  attr_accessor :passwordExpired
  attr_accessor :serverUrl
  attr_accessor :sessionId
  attr_accessor :userId
  attr_accessor :userInfo

  def initialize(passwordExpired = nil, serverUrl = nil, sessionId = nil, userId = nil, userInfo = nil)
    @passwordExpired = passwordExpired
    @serverUrl = serverUrl
    @sessionId = sessionId
    @userId = userId
    @userInfo = userInfo
  end
end

# {urn:partner.soap.sforce.com}Error
class Error
  @@schema_type = "Error"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["fields", "SOAP::SOAPString[]"], ["message", "SOAP::SOAPString"], ["statusCode", "SOAP::SOAPString"]]

  attr_accessor :fields
  attr_accessor :message
  attr_accessor :statusCode

  def initialize(fields = [], message = nil, statusCode = nil)
    @fields = fields
    @message = message
    @statusCode = statusCode
  end
end

# {urn:partner.soap.sforce.com}SaveResult
class SaveResult
  @@schema_type = "SaveResult"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["errors", "Error[]"], ["id", "SOAP::SOAPString"], ["success", "SOAP::SOAPBoolean"]]

  attr_accessor :errors
  attr_accessor :id
  attr_accessor :success

  def initialize(errors = [], id = nil, success = nil)
    @errors = errors
    @id = id
    @success = success
  end
end

# {urn:partner.soap.sforce.com}DeleteResult
class DeleteResult
  @@schema_type = "DeleteResult"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["errors", "Error[]"], ["id", "SOAP::SOAPString"], ["success", "SOAP::SOAPBoolean"]]

  attr_accessor :errors
  attr_accessor :id
  attr_accessor :success

  def initialize(errors = [], id = nil, success = nil)
    @errors = errors
    @id = id
    @success = success
  end
end

# {urn:partner.soap.sforce.com}LeadConvert
class LeadConvert
  @@schema_type = "LeadConvert"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["accountId", "SOAP::SOAPString"], ["contactId", "SOAP::SOAPString"], ["convertedStatus", "SOAP::SOAPString"], ["doNotCreateOpportunity", "SOAP::SOAPBoolean"], ["leadId", "SOAP::SOAPString"], ["opportunityName", "SOAP::SOAPString"], ["overwriteLeadSource", "SOAP::SOAPBoolean"], ["ownerId", "SOAP::SOAPString"], ["sendNotificationEmail", "SOAP::SOAPBoolean"]]

  attr_accessor :accountId
  attr_accessor :contactId
  attr_accessor :convertedStatus
  attr_accessor :doNotCreateOpportunity
  attr_accessor :leadId
  attr_accessor :opportunityName
  attr_accessor :overwriteLeadSource
  attr_accessor :ownerId
  attr_accessor :sendNotificationEmail

  def initialize(accountId = nil, contactId = nil, convertedStatus = nil, doNotCreateOpportunity = nil, leadId = nil, opportunityName = nil, overwriteLeadSource = nil, ownerId = nil, sendNotificationEmail = nil)
    @accountId = accountId
    @contactId = contactId
    @convertedStatus = convertedStatus
    @doNotCreateOpportunity = doNotCreateOpportunity
    @leadId = leadId
    @opportunityName = opportunityName
    @overwriteLeadSource = overwriteLeadSource
    @ownerId = ownerId
    @sendNotificationEmail = sendNotificationEmail
  end
end

# {urn:partner.soap.sforce.com}LeadConvertResult
class LeadConvertResult
  @@schema_type = "LeadConvertResult"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["accountId", "SOAP::SOAPString"], ["contactId", "SOAP::SOAPString"], ["errors", "Error[]"], ["leadId", "SOAP::SOAPString"], ["opportunityId", "SOAP::SOAPString"], ["success", "SOAP::SOAPBoolean"]]

  attr_accessor :accountId
  attr_accessor :contactId
  attr_accessor :errors
  attr_accessor :leadId
  attr_accessor :opportunityId
  attr_accessor :success

  def initialize(accountId = nil, contactId = nil, errors = [], leadId = nil, opportunityId = nil, success = nil)
    @accountId = accountId
    @contactId = contactId
    @errors = errors
    @leadId = leadId
    @opportunityId = opportunityId
    @success = success
  end
end

# {urn:partner.soap.sforce.com}DescribeSObjectResult
class DescribeSObjectResult
  @@schema_type = "DescribeSObjectResult"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["activateable", "SOAP::SOAPBoolean"], ["childRelationships", "ChildRelationship[]"], ["createable", "SOAP::SOAPBoolean"], ["custom", "SOAP::SOAPBoolean"], ["deletable", "SOAP::SOAPBoolean"], ["fields", "Field[]"], ["keyPrefix", "SOAP::SOAPString"], ["label", "SOAP::SOAPString"], ["labelPlural", "SOAP::SOAPString"], ["layoutable", "SOAP::SOAPBoolean"], ["name", "SOAP::SOAPString"], ["queryable", "SOAP::SOAPBoolean"], ["replicateable", "SOAP::SOAPBoolean"], ["retrieveable", "SOAP::SOAPBoolean"], ["searchable", "SOAP::SOAPBoolean"], ["undeletable", "SOAP::SOAPBoolean"], ["updateable", "SOAP::SOAPBoolean"], ["urlDetail", "SOAP::SOAPString"], ["urlEdit", "SOAP::SOAPString"], ["urlNew", "SOAP::SOAPString"]]

  attr_accessor :activateable
  attr_accessor :childRelationships
  attr_accessor :createable
  attr_accessor :custom
  attr_accessor :deletable
  attr_accessor :fields
  attr_accessor :keyPrefix
  attr_accessor :label
  attr_accessor :labelPlural
  attr_accessor :layoutable
  attr_accessor :name
  attr_accessor :queryable
  attr_accessor :replicateable
  attr_accessor :retrieveable
  attr_accessor :searchable
  attr_accessor :undeletable
  attr_accessor :updateable
  attr_accessor :urlDetail
  attr_accessor :urlEdit
  attr_accessor :urlNew

  def initialize(activateable = nil, childRelationships = [], createable = nil, custom = nil, deletable = nil, fields = [], keyPrefix = nil, label = nil, labelPlural = nil, layoutable = nil, name = nil, queryable = nil, replicateable = nil, retrieveable = nil, searchable = nil, undeletable = nil, updateable = nil, urlDetail = nil, urlEdit = nil, urlNew = nil)
    @activateable = activateable
    @childRelationships = childRelationships
    @createable = createable
    @custom = custom
    @deletable = deletable
    @fields = fields
    @keyPrefix = keyPrefix
    @label = label
    @labelPlural = labelPlural
    @layoutable = layoutable
    @name = name
    @queryable = queryable
    @replicateable = replicateable
    @retrieveable = retrieveable
    @searchable = searchable
    @undeletable = undeletable
    @updateable = updateable
    @urlDetail = urlDetail
    @urlEdit = urlEdit
    @urlNew = urlNew
  end
end

# {urn:partner.soap.sforce.com}ChildRelationship
class ChildRelationship
  @@schema_type = "ChildRelationship"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["cascadeDelete", "SOAP::SOAPBoolean"], ["childSObject", "SOAP::SOAPString"], ["field", "SOAP::SOAPString"]]

  attr_accessor :cascadeDelete
  attr_accessor :childSObject
  attr_accessor :field

  def initialize(cascadeDelete = nil, childSObject = nil, field = nil)
    @cascadeDelete = cascadeDelete
    @childSObject = childSObject
    @field = field
  end
end

# {urn:partner.soap.sforce.com}DescribeGlobalResult
class DescribeGlobalResult
  @@schema_type = "DescribeGlobalResult"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["encoding", "SOAP::SOAPString"], ["maxBatchSize", "SOAP::SOAPInt"], ["types", "SOAP::SOAPString[]"]]

  attr_accessor :encoding
  attr_accessor :maxBatchSize
  attr_accessor :types

  def initialize(encoding = nil, maxBatchSize = nil, types = [])
    @encoding = encoding
    @maxBatchSize = maxBatchSize
    @types = types
  end
end

# {urn:partner.soap.sforce.com}Field
class Field
  @@schema_type = "Field"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["autoNumber", "SOAP::SOAPBoolean"], ["byteLength", "SOAP::SOAPInt"], ["calculated", "SOAP::SOAPBoolean"], ["createable", "SOAP::SOAPBoolean"], ["custom", "SOAP::SOAPBoolean"], ["defaultedOnCreate", "SOAP::SOAPBoolean"], ["digits", "SOAP::SOAPInt"], ["filterable", "SOAP::SOAPBoolean"], ["label", "SOAP::SOAPString"], ["length", "SOAP::SOAPInt"], ["name", "SOAP::SOAPString"], ["nameField", "SOAP::SOAPBoolean"], ["nillable", "SOAP::SOAPBoolean"], ["picklistValues", "PicklistEntry[]"], ["precision", "SOAP::SOAPInt"], ["referenceTo", "SOAP::SOAPString[]"], ["restrictedPicklist", "SOAP::SOAPBoolean"], ["scale", "SOAP::SOAPInt"], ["soapType", "SOAP::SOAPString"], ["type", "SOAP::SOAPString"], ["updateable", "SOAP::SOAPBoolean"]]

  attr_accessor :autoNumber
  attr_accessor :byteLength
  attr_accessor :calculated
  attr_accessor :createable
  attr_accessor :custom
  attr_accessor :defaultedOnCreate
  attr_accessor :digits
  attr_accessor :filterable
  attr_accessor :label
  attr_accessor :length
  attr_accessor :name
  attr_accessor :nameField
  attr_accessor :nillable
  attr_accessor :picklistValues
  attr_accessor :precision
  attr_accessor :referenceTo
  attr_accessor :restrictedPicklist
  attr_accessor :scale
  attr_accessor :soapType
  attr_accessor :type
  attr_accessor :updateable

  def initialize(autoNumber = nil, byteLength = nil, calculated = nil, createable = nil, custom = nil, defaultedOnCreate = nil, digits = nil, filterable = nil, label = nil, length = nil, name = nil, nameField = nil, nillable = nil, picklistValues = [], precision = nil, referenceTo = [], restrictedPicklist = nil, scale = nil, soapType = nil, type = nil, updateable = nil)
    @autoNumber = autoNumber
    @byteLength = byteLength
    @calculated = calculated
    @createable = createable
    @custom = custom
    @defaultedOnCreate = defaultedOnCreate
    @digits = digits
    @filterable = filterable
    @label = label
    @length = length
    @name = name
    @nameField = nameField
    @nillable = nillable
    @picklistValues = picklistValues
    @precision = precision
    @referenceTo = referenceTo
    @restrictedPicklist = restrictedPicklist
    @scale = scale
    @soapType = soapType
    @type = type
    @updateable = updateable
  end
end

# {urn:partner.soap.sforce.com}PicklistEntry
class PicklistEntry
  @@schema_type = "PicklistEntry"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["active", "SOAP::SOAPBoolean"], ["defaultValue", "SOAP::SOAPBoolean"], ["label", "SOAP::SOAPString"], ["value", "SOAP::SOAPString"]]

  attr_accessor :active
  attr_accessor :defaultValue
  attr_accessor :label
  attr_accessor :value

  def initialize(active = nil, defaultValue = nil, label = nil, value = nil)
    @active = active
    @defaultValue = defaultValue
    @label = label
    @value = value
  end
end

# {urn:partner.soap.sforce.com}DescribeLayoutResult
class DescribeLayoutResult
  @@schema_type = "DescribeLayoutResult"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["layouts", "DescribeLayout[]"], ["recordTypeMappings", "RecordTypeMapping[]"]]

  attr_accessor :layouts
  attr_accessor :recordTypeMappings

  def initialize(layouts = [], recordTypeMappings = [])
    @layouts = layouts
    @recordTypeMappings = recordTypeMappings
  end
end

# {urn:partner.soap.sforce.com}DescribeLayout
class DescribeLayout
  @@schema_type = "DescribeLayout"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["detailLayoutSections", "DescribeLayoutSection[]"], ["editLayoutSections", "DescribeLayoutSection[]"], ["id", "SOAP::SOAPString"]]

  attr_accessor :detailLayoutSections
  attr_accessor :editLayoutSections
  attr_accessor :id

  def initialize(detailLayoutSections = [], editLayoutSections = [], id = nil)
    @detailLayoutSections = detailLayoutSections
    @editLayoutSections = editLayoutSections
    @id = id
  end
end

# {urn:partner.soap.sforce.com}DescribeLayoutSection
class DescribeLayoutSection
  @@schema_type = "DescribeLayoutSection"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["columns", "SOAP::SOAPInt"], ["heading", "SOAP::SOAPString"], ["layoutRows", "DescribeLayoutRow[]"], ["rows", "SOAP::SOAPInt"], ["useCollapsibleSection", "SOAP::SOAPBoolean"], ["useHeading", "SOAP::SOAPBoolean"]]

  attr_accessor :columns
  attr_accessor :heading
  attr_accessor :layoutRows
  attr_accessor :rows
  attr_accessor :useCollapsibleSection
  attr_accessor :useHeading

  def initialize(columns = nil, heading = nil, layoutRows = [], rows = nil, useCollapsibleSection = nil, useHeading = nil)
    @columns = columns
    @heading = heading
    @layoutRows = layoutRows
    @rows = rows
    @useCollapsibleSection = useCollapsibleSection
    @useHeading = useHeading
  end
end

# {urn:partner.soap.sforce.com}DescribeLayoutRow
class DescribeLayoutRow
  @@schema_type = "DescribeLayoutRow"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["layoutItems", "DescribeLayoutItem[]"], ["numItems", "SOAP::SOAPInt"]]

  attr_accessor :layoutItems
  attr_accessor :numItems

  def initialize(layoutItems = [], numItems = nil)
    @layoutItems = layoutItems
    @numItems = numItems
  end
end

# {urn:partner.soap.sforce.com}DescribeLayoutItem
class DescribeLayoutItem
  @@schema_type = "DescribeLayoutItem"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["editable", "SOAP::SOAPBoolean"], ["label", "SOAP::SOAPString"], ["layoutComponents", "DescribeLayoutComponent[]"], ["placeholder", "SOAP::SOAPBoolean"], ["required", "SOAP::SOAPBoolean"]]

  attr_accessor :editable
  attr_accessor :label
  attr_accessor :layoutComponents
  attr_accessor :placeholder
  attr_accessor :required

  def initialize(editable = nil, label = nil, layoutComponents = [], placeholder = nil, required = nil)
    @editable = editable
    @label = label
    @layoutComponents = layoutComponents
    @placeholder = placeholder
    @required = required
  end
end

# {urn:partner.soap.sforce.com}DescribeLayoutComponent
class DescribeLayoutComponent
  @@schema_type = "DescribeLayoutComponent"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["tabOrder", "SOAP::SOAPInt"], ["type", "SOAP::SOAPString"], ["value", "SOAP::SOAPString"]]

  attr_accessor :tabOrder
  attr_accessor :type
  attr_accessor :value

  def initialize(tabOrder = nil, type = nil, value = nil)
    @tabOrder = tabOrder
    @type = type
    @value = value
  end
end

# {urn:partner.soap.sforce.com}RecordTypeMapping
class RecordTypeMapping
  @@schema_type = "RecordTypeMapping"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["available", "SOAP::SOAPBoolean"], ["defaultRecordTypeMapping", "SOAP::SOAPBoolean"], ["layoutId", "SOAP::SOAPString"], ["name", "SOAP::SOAPString"], ["picklistsForRecordType", "PicklistForRecordType[]"], ["recordTypeId", "SOAP::SOAPString"]]

  attr_accessor :available
  attr_accessor :defaultRecordTypeMapping
  attr_accessor :layoutId
  attr_accessor :name
  attr_accessor :picklistsForRecordType
  attr_accessor :recordTypeId

  def initialize(available = nil, defaultRecordTypeMapping = nil, layoutId = nil, name = nil, picklistsForRecordType = [], recordTypeId = nil)
    @available = available
    @defaultRecordTypeMapping = defaultRecordTypeMapping
    @layoutId = layoutId
    @name = name
    @picklistsForRecordType = picklistsForRecordType
    @recordTypeId = recordTypeId
  end
end

# {urn:partner.soap.sforce.com}PicklistForRecordType
class PicklistForRecordType
  @@schema_type = "PicklistForRecordType"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["picklistName", "SOAP::SOAPString"], ["picklistValues", "PicklistEntry[]"]]

  attr_accessor :picklistName
  attr_accessor :picklistValues

  def initialize(picklistName = nil, picklistValues = [])
    @picklistName = picklistName
    @picklistValues = picklistValues
  end
end

# {urn:partner.soap.sforce.com}DescribeTabSetResult
class DescribeTabSetResult
  @@schema_type = "DescribeTabSetResult"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["label", "SOAP::SOAPString"], ["logoUrl", "SOAP::SOAPString"], ["selected", "SOAP::SOAPBoolean"], ["tabs", "DescribeTab[]"]]

  attr_accessor :label
  attr_accessor :logoUrl
  attr_accessor :selected
  attr_accessor :tabs

  def initialize(label = nil, logoUrl = nil, selected = nil, tabs = [])
    @label = label
    @logoUrl = logoUrl
    @selected = selected
    @tabs = tabs
  end
end

# {urn:partner.soap.sforce.com}DescribeTab
class DescribeTab
  @@schema_type = "DescribeTab"
  @@schema_ns = "urn:partner.soap.sforce.com"
  @@schema_element = [["custom", "SOAP::SOAPBoolean"], ["label", "SOAP::SOAPString"], ["sobjectName", "SOAP::SOAPString"], ["url", "SOAP::SOAPString"]]

  attr_accessor :custom
  attr_accessor :label
  attr_accessor :sobjectName
  attr_accessor :url

  def initialize(custom = nil, label = nil, sobjectName = nil, url = nil)
    @custom = custom
    @label = label
    @sobjectName = sobjectName
    @url = url
  end
end

# {urn:fault.partner.soap.sforce.com}ApiFault
class ApiFault
  @@schema_type = "ApiFault"
  @@schema_ns = "urn:fault.partner.soap.sforce.com"
  @@schema_element = [["exceptionCode", "SOAP::SOAPString"], ["exceptionMessage", "SOAP::SOAPString"]]

  attr_accessor :exceptionCode
  attr_accessor :exceptionMessage

  def initialize(exceptionCode = nil, exceptionMessage = nil)
    @exceptionCode = exceptionCode
    @exceptionMessage = exceptionMessage
  end
end

# {urn:fault.partner.soap.sforce.com}ApiQueryFault
class ApiQueryFault
  @@schema_type = "ApiQueryFault"
  @@schema_ns = "urn:fault.partner.soap.sforce.com"
  @@schema_element = []

  def initialize
  end
end

# {urn:fault.partner.soap.sforce.com}LoginFault
class LoginFault
  @@schema_type = "LoginFault"
  @@schema_ns = "urn:fault.partner.soap.sforce.com"
  @@schema_element = []

  def initialize
  end
end

# {urn:fault.partner.soap.sforce.com}InvalidQueryLocatorFault
class InvalidQueryLocatorFault
  @@schema_type = "InvalidQueryLocatorFault"
  @@schema_ns = "urn:fault.partner.soap.sforce.com"
  @@schema_element = []

  def initialize
  end
end

# {urn:fault.partner.soap.sforce.com}InvalidNewPasswordFault
class InvalidNewPasswordFault
  @@schema_type = "InvalidNewPasswordFault"
  @@schema_ns = "urn:fault.partner.soap.sforce.com"
  @@schema_element = []

  def initialize
  end
end

# {urn:fault.partner.soap.sforce.com}InvalidIdFault
class InvalidIdFault
  @@schema_type = "InvalidIdFault"
  @@schema_ns = "urn:fault.partner.soap.sforce.com"
  @@schema_element = []

  def initialize
  end
end

# {urn:fault.partner.soap.sforce.com}UnexpectedErrorFault
class UnexpectedErrorFault
  @@schema_type = "UnexpectedErrorFault"
  @@schema_ns = "urn:fault.partner.soap.sforce.com"
  @@schema_element = []

  def initialize
  end
end

# {urn:fault.partner.soap.sforce.com}InvalidFieldFault
class InvalidFieldFault
  @@schema_type = "InvalidFieldFault"
  @@schema_ns = "urn:fault.partner.soap.sforce.com"
  @@schema_element = []

  def initialize
  end
end

# {urn:fault.partner.soap.sforce.com}InvalidSObjectFault
class InvalidSObjectFault
  @@schema_type = "InvalidSObjectFault"
  @@schema_ns = "urn:fault.partner.soap.sforce.com"
  @@schema_element = []

  def initialize
  end
end

# {urn:fault.partner.soap.sforce.com}MalformedQueryFault
class MalformedQueryFault
  @@schema_type = "MalformedQueryFault"
  @@schema_ns = "urn:fault.partner.soap.sforce.com"
  @@schema_element = []

  def initialize
  end
end

# {urn:fault.partner.soap.sforce.com}MalformedSearchFault
class MalformedSearchFault
  @@schema_type = "MalformedSearchFault"
  @@schema_ns = "urn:fault.partner.soap.sforce.com"
  @@schema_element = []

  def initialize
  end
end

# {urn:partner.soap.sforce.com}StatusCode
module StatusCode
  ASSIGNEE_TYPE_REQUIRED = "ASSIGNEE_TYPE_REQUIRED"
  BAD_CUSTOM_ENTITY_PARENT_DOMAIN = "BAD_CUSTOM_ENTITY_PARENT_DOMAIN"
  CANNOT_CASCADE_PRODUCT_ACTIVE = "CANNOT_CASCADE_PRODUCT_ACTIVE"
  CANNOT_DEACTIVATE_DIVISION = "CANNOT_DEACTIVATE_DIVISION"
  CANNOT_INSERT_UPDATE_ACTIVATE_ENTITY = "CANNOT_INSERT_UPDATE_ACTIVATE_ENTITY"
  CANNOT_REPARENT_RECORD = "CANNOT_REPARENT_RECORD"
  CANNOT_RESOLVE_NAME = "CANNOT_RESOLVE_NAME"
  CANNOT_UPDATE_CONVERTED_LEAD = "CANNOT_UPDATE_CONVERTED_LEAD"
  CANT_DISABLE_CORP_CURRENCY = "CANT_DISABLE_CORP_CURRENCY"
  CANT_UNSET_CORP_CURRENCY = "CANT_UNSET_CORP_CURRENCY"
  CHILD_SHARE_FAILS_PARENT = "CHILD_SHARE_FAILS_PARENT"
  CIRCULAR_DEPENDENCY = "CIRCULAR_DEPENDENCY"
  CUSTOM_ENTITY_OR_FIELD_LIMIT = "CUSTOM_ENTITY_OR_FIELD_LIMIT"
  CUSTOM_FIELD_INDEX_LIMIT_EXCEEDED = "CUSTOM_FIELD_INDEX_LIMIT_EXCEEDED"
  CUSTOM_INDEX_EXISTS = "CUSTOM_INDEX_EXISTS"
  DELETE_FAILED = "DELETE_FAILED"
  DELETE_REQUIRED_ON_CASCADE = "DELETE_REQUIRED_ON_CASCADE"
  DEPENDENCY_EXISTS = "DEPENDENCY_EXISTS"
  DUPLICATE_CASE_SOLUTION = "DUPLICATE_CASE_SOLUTION"
  DUPLICATE_CUSTOM_TAB_MOTIF = "DUPLICATE_CUSTOM_TAB_MOTIF"
  DUPLICATE_DEVELOPER_NAME = "DUPLICATE_DEVELOPER_NAME"
  DUPLICATE_MASTER_LABEL = "DUPLICATE_MASTER_LABEL"
  DUPLICATE_USERNAME = "DUPLICATE_USERNAME"
  DUPLICATE_VALUE = "DUPLICATE_VALUE"
  ENTITY_FAILED_IFLASTMODIFIED_ON_UPDATE = "ENTITY_FAILED_IFLASTMODIFIED_ON_UPDATE"
  ENTITY_IS_ARCHIVED = "ENTITY_IS_ARCHIVED"
  ENTITY_IS_DELETED = "ENTITY_IS_DELETED"
  ENTITY_IS_LOCKED = "ENTITY_IS_LOCKED"
  FAILED_ACTIVATION = "FAILED_ACTIVATION"
  FIELD_INTEGRITY_EXCEPTION = "FIELD_INTEGRITY_EXCEPTION"
  INACTIVE_OWNER_OR_USER = "INACTIVE_OWNER_OR_USER"
  INSUFFICIENT_ACCESS_ON_CROSS_REFERENCE_ENTITY = "INSUFFICIENT_ACCESS_ON_CROSS_REFERENCE_ENTITY"
  INSUFFICIENT_ACCESS_OR_READONLY = "INSUFFICIENT_ACCESS_OR_READONLY"
  INVALID_ACCESS_LEVEL = "INVALID_ACCESS_LEVEL"
  INVALID_ARGUMENT_TYPE = "INVALID_ARGUMENT_TYPE"
  INVALID_ASSIGNEE_TYPE = "INVALID_ASSIGNEE_TYPE"
  INVALID_ASSIGNMENT_RULE = "INVALID_ASSIGNMENT_RULE"
  INVALID_BATCH_OPERATION = "INVALID_BATCH_OPERATION"
  INVALID_CREDIT_CARD_INFO = "INVALID_CREDIT_CARD_INFO"
  INVALID_CROSS_REFERENCE_KEY = "INVALID_CROSS_REFERENCE_KEY"
  INVALID_CROSS_REFERENCE_TYPE_FOR_FIELD = "INVALID_CROSS_REFERENCE_TYPE_FOR_FIELD"
  INVALID_CURRENCY_CONV_RATE = "INVALID_CURRENCY_CONV_RATE"
  INVALID_CURRENCY_ISO = "INVALID_CURRENCY_ISO"
  INVALID_EMAIL_ADDRESS = "INVALID_EMAIL_ADDRESS"
  INVALID_EMPTY_KEY_OWNER = "INVALID_EMPTY_KEY_OWNER"
  INVALID_FIELD = "INVALID_FIELD"
  INVALID_FIELD_FOR_INSERT_UPDATE = "INVALID_FIELD_FOR_INSERT_UPDATE"
  INVALID_FILTER_ACTION = "INVALID_FILTER_ACTION"
  INVALID_ID_FIELD = "INVALID_ID_FIELD"
  INVALID_INET_ADDRESS = "INVALID_INET_ADDRESS"
  INVALID_LINEITEM_CLONE_STATE = "INVALID_LINEITEM_CLONE_STATE"
  INVALID_OPERATION = "INVALID_OPERATION"
  INVALID_OPERATOR = "INVALID_OPERATOR"
  INVALID_OR_NULL_FOR_RESTRICTED_PICKLIST = "INVALID_OR_NULL_FOR_RESTRICTED_PICKLIST"
  INVALID_STATUS = "INVALID_STATUS"
  INVALID_TYPE = "INVALID_TYPE"
  INVALID_TYPE_FOR_OPERATION = "INVALID_TYPE_FOR_OPERATION"
  INVALID_TYPE_ON_FIELD_IN_RECORD = "INVALID_TYPE_ON_FIELD_IN_RECORD"
  LAST_MODIFIED_SINCE_TOO_OLD = "LAST_MODIFIED_SINCE_TOO_OLD"
  LICENSE_LIMIT_EXCEEDED = "LICENSE_LIMIT_EXCEEDED"
  MALFORMED_ID = "MALFORMED_ID"
  MAXIMUM_CCEMAILS_EXCEEDED = "MAXIMUM_CCEMAILS_EXCEEDED"
  MAXIMUM_DASHBOARD_COMPONENTS_EXCEEDED = "MAXIMUM_DASHBOARD_COMPONENTS_EXCEEDED"
  MAXIMUM_SIZE_OF_ATTACHMENT = "MAXIMUM_SIZE_OF_ATTACHMENT"
  MAXIMUM_SIZE_OF_DOCUMENT = "MAXIMUM_SIZE_OF_DOCUMENT"
  MAX_ACTIONS_PER_RULE_EXCEEDED = "MAX_ACTIONS_PER_RULE_EXCEEDED"
  MAX_ACTIVE_RULES_EXCEEDED = "MAX_ACTIVE_RULES_EXCEEDED"
  MAX_TASK_DESCRIPTION_EXCEEEDED = "MAX_TASK_DESCRIPTION_EXCEEEDED"
  MISSING_ARGUMENT = "MISSING_ARGUMENT"
  NONUNIQUE_SHIPPING_ADDRESS = "NONUNIQUE_SHIPPING_ADDRESS"
  NUMBER_OUTSIDE_VALID_RANGE = "NUMBER_OUTSIDE_VALID_RANGE"
  PRIVATE_CONTACT_ON_ASSET = "PRIVATE_CONTACT_ON_ASSET"
  REQUIRED_FIELD_MISSING = "REQUIRED_FIELD_MISSING"
  SHARE_NEEDED_FOR_CHILD_OWNER = "SHARE_NEEDED_FOR_CHILD_OWNER"
  STANDARD_PRICE_NOT_DEFINED = "STANDARD_PRICE_NOT_DEFINED"
  STORAGE_LIMIT_EXCEEDED = "STORAGE_LIMIT_EXCEEDED"
  TEXT_DATA_OUTSIDE_SUPPORTED_CHARSET = "TEXT_DATA_OUTSIDE_SUPPORTED_CHARSET"
  TOO_MANY_ENUM_VALUE = "TOO_MANY_ENUM_VALUE"
  TRANSFER_REQUIRES_READ = "TRANSFER_REQUIRES_READ"
  UNKNOWN_EXCEPTION = "UNKNOWN_EXCEPTION"
  UNSPECIFIED_EMAIL_ADDRESS = "UNSPECIFIED_EMAIL_ADDRESS"
end

# {urn:partner.soap.sforce.com}fieldType
module FieldType
  Base64 = "base64"
  Boolean = "boolean"
  Combobox = "combobox"
  Currency = "currency"
  Date = "date"
  Datetime = "datetime"
  Double = "double"
  Email = "email"
  Id = "id"
  Int = "int"
  Multipicklist = "multipicklist"
  Percent = "percent"
  Phone = "phone"
  Picklist = "picklist"
  Reference = "reference"
  String = "string"
  Textarea = "textarea"
  Url = "url"
end

# {urn:partner.soap.sforce.com}soapType
module SoapType
  TnsID = "tns:ID"
  XsdBase64Binary = "xsd:base64Binary"
  XsdBoolean = "xsd:boolean"
  XsdDate = "xsd:date"
  XsdDateTime = "xsd:dateTime"
  XsdDouble = "xsd:double"
  XsdInt = "xsd:int"
  XsdString = "xsd:string"
end

# {urn:partner.soap.sforce.com}layoutComponentType
module LayoutComponentType
  Field = "Field"
  Separator = "Separator"
end

# {urn:fault.partner.soap.sforce.com}ExceptionCode
module ExceptionCode
  API_CURRENTLY_DISABLED = "API_CURRENTLY_DISABLED"
  API_DISABLED_FOR_ORG = "API_DISABLED_FOR_ORG"
  EMAIL_TO_CASE_LIMIT_EXCEEDED = "EMAIL_TO_CASE_LIMIT_EXCEEDED"
  EMAIL_TO_CASE_NOT_ENABLED = "EMAIL_TO_CASE_NOT_ENABLED"
  EXCEEDED_ID_LIMIT = "EXCEEDED_ID_LIMIT"
  EXCEEDED_LEAD_CONVERT_LIMIT = "EXCEEDED_LEAD_CONVERT_LIMIT"
  EXCEEDED_MAX_SIZE_REQUEST = "EXCEEDED_MAX_SIZE_REQUEST"
  EXCEEDED_MAX_TYPES_LIMIT = "EXCEEDED_MAX_TYPES_LIMIT"
  EXCEEDED_QUOTA = "EXCEEDED_QUOTA"
  EXCEEDED_RATE_LIMIT = "EXCEEDED_RATE_LIMIT"
  FUNCTIONALITY_NOT_ENABLED = "FUNCTIONALITY_NOT_ENABLED"
  IMAGE_TOO_LARGE = "IMAGE_TOO_LARGE"
  INACTIVE_OWNER_OR_USER = "INACTIVE_OWNER_OR_USER"
  INSUFFICIENT_ACCESS = "INSUFFICIENT_ACCESS"
  INVALID_ASSIGNMENT_RULE = "INVALID_ASSIGNMENT_RULE"
  INVALID_BATCH_SIZE = "INVALID_BATCH_SIZE"
  INVALID_CLIENT = "INVALID_CLIENT"
  INVALID_CROSS_REFERENCE_KEY = "INVALID_CROSS_REFERENCE_KEY"
  INVALID_FIELD = "INVALID_FIELD"
  INVALID_ID_FIELD = "INVALID_ID_FIELD"
  INVALID_LOGIN = "INVALID_LOGIN"
  INVALID_NEW_PASSWORD = "INVALID_NEW_PASSWORD"
  INVALID_OPERATION = "INVALID_OPERATION"
  INVALID_OPERATION_WITH_EXPIRED_PASSWORD = "INVALID_OPERATION_WITH_EXPIRED_PASSWORD"
  INVALID_QUERY_FILTER_OPERATOR = "INVALID_QUERY_FILTER_OPERATOR"
  INVALID_QUERY_LOCATOR = "INVALID_QUERY_LOCATOR"
  INVALID_QUERY_SCOPE = "INVALID_QUERY_SCOPE"
  INVALID_REPLICATION_DATE = "INVALID_REPLICATION_DATE"
  INVALID_SEARCH = "INVALID_SEARCH"
  INVALID_SEARCH_SCOPE = "INVALID_SEARCH_SCOPE"
  INVALID_SESSION_ID = "INVALID_SESSION_ID"
  INVALID_SOAP_HEADER = "INVALID_SOAP_HEADER"
  INVALID_SSO_GATEWAY_URL = "INVALID_SSO_GATEWAY_URL"
  INVALID_TYPE = "INVALID_TYPE"
  INVALID_TYPE_FOR_OPERATION = "INVALID_TYPE_FOR_OPERATION"
  LOGIN_DURING_RESTRICTED_DOMAIN = "LOGIN_DURING_RESTRICTED_DOMAIN"
  LOGIN_DURING_RESTRICTED_TIME = "LOGIN_DURING_RESTRICTED_TIME"
  MALFORMED_ID = "MALFORMED_ID"
  MALFORMED_QUERY = "MALFORMED_QUERY"
  MALFORMED_SEARCH = "MALFORMED_SEARCH"
  MISSING_ARGUMENT = "MISSING_ARGUMENT"
  OPERATION_TOO_LARGE = "OPERATION_TOO_LARGE"
  ORG_LOCKED = "ORG_LOCKED"
  PASSWORD_LOCKOUT = "PASSWORD_LOCKOUT"
  QUERY_TIMEOUT = "QUERY_TIMEOUT"
  QUERY_TOO_COMPLICATED = "QUERY_TOO_COMPLICATED"
  SERVER_UNAVAILABLE = "SERVER_UNAVAILABLE"
  SSO_SERVICE_DOWN = "SSO_SERVICE_DOWN"
  TRIAL_EXPIRED = "TRIAL_EXPIRED"
  UNKNOWN_EXCEPTION = "UNKNOWN_EXCEPTION"
  UNSUPPORTED_API_VERSION = "UNSUPPORTED_API_VERSION"
  UNSUPPORTED_CLIENT = "UNSUPPORTED_CLIENT"
end

# {urn:fault.partner.soap.sforce.com}FaultCode
module FaultCode
  FnsAPI_CURRENTLY_DISABLED = "fns:API_CURRENTLY_DISABLED"
  FnsAPI_DISABLED_FOR_ORG = "fns:API_DISABLED_FOR_ORG"
  FnsEMAIL_TO_CASE_LIMIT_EXCEEDED = "fns:EMAIL_TO_CASE_LIMIT_EXCEEDED"
  FnsEMAIL_TO_CASE_NOT_ENABLED = "fns:EMAIL_TO_CASE_NOT_ENABLED"
  FnsEXCEEDED_ID_LIMIT = "fns:EXCEEDED_ID_LIMIT"
  FnsEXCEEDED_LEAD_CONVERT_LIMIT = "fns:EXCEEDED_LEAD_CONVERT_LIMIT"
  FnsEXCEEDED_MAX_SIZE_REQUEST = "fns:EXCEEDED_MAX_SIZE_REQUEST"
  FnsEXCEEDED_MAX_TYPES_LIMIT = "fns:EXCEEDED_MAX_TYPES_LIMIT"
  FnsEXCEEDED_QUOTA = "fns:EXCEEDED_QUOTA"
  FnsEXCEEDED_RATE_LIMIT = "fns:EXCEEDED_RATE_LIMIT"
  FnsFUNCTIONALITY_NOT_ENABLED = "fns:FUNCTIONALITY_NOT_ENABLED"
  FnsIMAGE_TOO_LARGE = "fns:IMAGE_TOO_LARGE"
  FnsINACTIVE_OWNER_OR_USER = "fns:INACTIVE_OWNER_OR_USER"
  FnsINSUFFICIENT_ACCESS = "fns:INSUFFICIENT_ACCESS"
  FnsINVALID_ASSIGNMENT_RULE = "fns:INVALID_ASSIGNMENT_RULE"
  FnsINVALID_BATCH_SIZE = "fns:INVALID_BATCH_SIZE"
  FnsINVALID_CLIENT = "fns:INVALID_CLIENT"
  FnsINVALID_CROSS_REFERENCE_KEY = "fns:INVALID_CROSS_REFERENCE_KEY"
  FnsINVALID_FIELD = "fns:INVALID_FIELD"
  FnsINVALID_ID_FIELD = "fns:INVALID_ID_FIELD"
  FnsINVALID_LOGIN = "fns:INVALID_LOGIN"
  FnsINVALID_NEW_PASSWORD = "fns:INVALID_NEW_PASSWORD"
  FnsINVALID_OPERATION = "fns:INVALID_OPERATION"
  FnsINVALID_OPERATION_WITH_EXPIRED_PASSWORD = "fns:INVALID_OPERATION_WITH_EXPIRED_PASSWORD"
  FnsINVALID_QUERY_FILTER_OPERATOR = "fns:INVALID_QUERY_FILTER_OPERATOR"
  FnsINVALID_QUERY_LOCATOR = "fns:INVALID_QUERY_LOCATOR"
  FnsINVALID_QUERY_SCOPE = "fns:INVALID_QUERY_SCOPE"
  FnsINVALID_REPLICATION_DATE = "fns:INVALID_REPLICATION_DATE"
  FnsINVALID_SEARCH = "fns:INVALID_SEARCH"
  FnsINVALID_SEARCH_SCOPE = "fns:INVALID_SEARCH_SCOPE"
  FnsINVALID_SESSION_ID = "fns:INVALID_SESSION_ID"
  FnsINVALID_SOAP_HEADER = "fns:INVALID_SOAP_HEADER"
  FnsINVALID_SSO_GATEWAY_URL = "fns:INVALID_SSO_GATEWAY_URL"
  FnsINVALID_TYPE = "fns:INVALID_TYPE"
  FnsINVALID_TYPE_FOR_OPERATION = "fns:INVALID_TYPE_FOR_OPERATION"
  FnsLOGIN_DURING_RESTRICTED_DOMAIN = "fns:LOGIN_DURING_RESTRICTED_DOMAIN"
  FnsLOGIN_DURING_RESTRICTED_TIME = "fns:LOGIN_DURING_RESTRICTED_TIME"
  FnsMALFORMED_ID = "fns:MALFORMED_ID"
  FnsMALFORMED_QUERY = "fns:MALFORMED_QUERY"
  FnsMALFORMED_SEARCH = "fns:MALFORMED_SEARCH"
  FnsMISSING_ARGUMENT = "fns:MISSING_ARGUMENT"
  FnsOPERATION_TOO_LARGE = "fns:OPERATION_TOO_LARGE"
  FnsORG_LOCKED = "fns:ORG_LOCKED"
  FnsPASSWORD_LOCKOUT = "fns:PASSWORD_LOCKOUT"
  FnsQUERY_TIMEOUT = "fns:QUERY_TIMEOUT"
  FnsQUERY_TOO_COMPLICATED = "fns:QUERY_TOO_COMPLICATED"
  FnsSERVER_UNAVAILABLE = "fns:SERVER_UNAVAILABLE"
  FnsSSO_SERVICE_DOWN = "fns:SSO_SERVICE_DOWN"
  FnsTRIAL_EXPIRED = "fns:TRIAL_EXPIRED"
  FnsUNKNOWN_EXCEPTION = "fns:UNKNOWN_EXCEPTION"
  FnsUNSUPPORTED_API_VERSION = "fns:UNSUPPORTED_API_VERSION"
  FnsUNSUPPORTED_CLIENT = "fns:UNSUPPORTED_CLIENT"
end
