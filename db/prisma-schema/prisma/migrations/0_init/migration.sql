BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[__EFMigrationsHistory] (
    [MigrationId] NVARCHAR(150) NOT NULL,
    [ProductVersion] NVARCHAR(32) NOT NULL,
    CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED ([MigrationId])
);

-- CreateTable
CREATE TABLE [dbo].[Administratorin] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Vorname] NVARCHAR(max),
    [Nachname] NVARCHAR(max),
    [Passwort] NVARCHAR(max),
    [EMailAdresse] NVARCHAR(1000) NOT NULL,
    [Telefonnummer] NVARCHAR(max),
    CONSTRAINT [PK_Administratorin] PRIMARY KEY CLUSTERED ([Id]),
    CONSTRAINT [Administratorin_EMailAdresse_key] UNIQUE NONCLUSTERED ([EMailAdresse])
);

-- CreateTable
CREATE TABLE [dbo].[ActionItem] (
    [ActionItemId] INT NOT NULL IDENTITY(1,1),
    [TenantId] INT NOT NULL,
    [AnsprechpartnerId] INT NOT NULL,
    [FahrerId] INT NOT NULL,
    [NodeName] NVARCHAR(max),
    [ActionName] NVARCHAR(max),
    [ActionSelected] BIT NOT NULL,
    [ActionCommand] NVARCHAR(max),
    [NodeId] NVARCHAR(max),
    [Excluded] BIT NOT NULL,
    [Email] NVARCHAR(max),
    CONSTRAINT [PK_ActionItem] PRIMARY KEY CLUSTERED ([ActionItemId])
);

-- CreateTable
CREATE TABLE [dbo].[Adresse] (
    [AdresseId] INT NOT NULL IDENTITY(1,1),
    [Strasse] NVARCHAR(max),
    [Plz] NVARCHAR(max),
    [Ort] NVARCHAR(max),
    [Land] NVARCHAR(max) NOT NULL,
    [IstAktiv] BIT,
    [IstAktivGueltigAb] DATETIME2,
    [IstAktivGueltigBis] DATETIME2,
    [AdressTyp] NVARCHAR(max) NOT NULL,
    [Oertlichkeit] NVARCHAR(max),
    [Info] NVARCHAR(max),
    [Location] geography,
    [X] FLOAT(53),
    [Y] FLOAT(53),
    [Emailadresse] NVARCHAR(255),
    [Telefonnummer] NVARCHAR(max),
    [Faxnummer] NVARCHAR(max),
    [Mobilnummer] NVARCHAR(max),
    [FahrerId] INT,
    [SchadenId] INT,
    [KundeTenantItemId] INT,
    [WerkstattId] INT,
    [DienstleisterId] INT,
    [InnuceId] NVARCHAR(max),
    [FahrzeugTenantItemId] INT,
    [KontaktBeziehungId] INT,
    [KontaktBeziehungId1] INT,
    [AdressVerweis] INT NOT NULL,
    [Automatik] BIT,
    CONSTRAINT [PK_Adresse] PRIMARY KEY CLUSTERED ([AdresseId])
);

-- CreateTable
CREATE TABLE [dbo].[Ansprechpartner] (
    [AnsprechpartnerId] INT NOT NULL IDENTITY(1,1),
    [Vorname] NVARCHAR(max),
    [Nachname] NVARCHAR(max),
    [AnsprechpartnerFunktion] NVARCHAR(max) NOT NULL,
    [Email] NVARCHAR(max),
    [Mobil] NVARCHAR(max),
    [Telefon] NVARCHAR(max),
    [DienstleisterId] INT,
    [KundeTenantItemId] INT,
    [Fax] NVARCHAR(max),
    [Automatik] BIT,
    CONSTRAINT [PK_Ansprechpartner] PRIMARY KEY CLUSTERED ([AnsprechpartnerId])
);

-- CreateTable
CREATE TABLE [dbo].[AppointmentData] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Subject] NVARCHAR(max),
    [Location] NVARCHAR(max),
    [Description] NVARCHAR(max),
    [StartTime] DATETIME2,
    [EndTime] DATETIME2,
    [IsAllDay] BIT,
    [CategoryColor] NVARCHAR(max),
    [RecurrenceRule] NVARCHAR(max),
    [EventType] NVARCHAR(max),
    [RecurrenceID] INT,
    [RecurrenceException] NVARCHAR(max),
    [StartTimezone] NVARCHAR(max),
    [EndTimezone] NVARCHAR(max),
    [FahrzeugTenantItemId] INT,
    [KundeTenantItemId] INT,
    [ActionKommando] NVARCHAR(max),
    [Erinnerert] INT NOT NULL CONSTRAINT [DF__Appointme__Erinn__789EE131] DEFAULT 0,
    [Prioritaet] NVARCHAR(max),
    [Status] NVARCHAR(max),
    [LeasingId] INT,
    [SchadenId] INT,
    [VersicherungId] INT,
    [Adressat] NVARCHAR(max),
    [Erledigt] BIT,
    [RuleId] INT,
    [WfStateId] INT,
    [PreviousStateData] NVARCHAR(max),
    [Vorlage] NVARCHAR(max),
    [Erinnerungsintervall] NVARCHAR(max),
    [UeberwachtDurch] NVARCHAR(max),
    CONSTRAINT [PK_AppointmentData] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Arbeitsgruppen] (
    [ArbeitsgruppeId] INT NOT NULL IDENTITY(1,1),
    [Bezeichnung] NVARCHAR(max),
    [Bereich] NVARCHAR(max),
    CONSTRAINT [PK_Arbeitsgruppen] PRIMARY KEY CLUSTERED ([ArbeitsgruppeId])
);

-- CreateTable
CREATE TABLE [dbo].[Arbeitszeit] (
    [ArbeitszeitId] INT NOT NULL IDENTITY(1,1),
    [ZeiteinheitenFinal] DECIMAL(18,2) NOT NULL,
    [ZeiteinheitenAusKv] DECIMAL(18,2) NOT NULL,
    [PreisProEinheitFinal] DECIMAL(18,2) NOT NULL,
    [Bezeichnung] NVARCHAR(max),
    [KostenvoranschlagId] INT NOT NULL,
    [UniqueKvId] NVARCHAR(max),
    [GesamtpreisAusKv] DECIMAL(18,2) NOT NULL CONSTRAINT [DF__Arbeitsze__Gesam__63F8CA06] DEFAULT 0.0,
    [GesamtpreisFinal] DECIMAL(18,2) NOT NULL CONSTRAINT [DF__Arbeitsze__Gesam__64ECEE3F] DEFAULT 0.0,
    [PositionStatus] INT NOT NULL CONSTRAINT [DF__Arbeitsze__Posit__65E11278] DEFAULT 0,
    [PreisProEinheitAusKv] DECIMAL(18,2) NOT NULL CONSTRAINT [DF__Arbeitsze__Preis__66D536B1] DEFAULT 0.0,
    [Bemerkung] NVARCHAR(max),
    [APN] NVARCHAR(max),
    [Arbeitsart] NVARCHAR(max),
    [DVN] NVARCHAR(max),
    [RC] NVARCHAR(max),
    [Stufe] NVARCHAR(max),
    CONSTRAINT [PK_Arbeitszeit] PRIMARY KEY CLUSTERED ([ArbeitszeitId])
);

-- CreateTable
CREATE TABLE [dbo].[Audit] (
    [AuditId] INT NOT NULL IDENTITY(1,1),
    [DateTime] DATETIME2 NOT NULL,
    [Username] NVARCHAR(max),
    [TableName] NVARCHAR(128) NOT NULL,
    [Action] NVARCHAR(50) NOT NULL,
    [KeyValues] NVARCHAR(max),
    [OldValues] NVARCHAR(max),
    [NewValues] NVARCHAR(max),
    CONSTRAINT [PK_Audit] PRIMARY KEY CLUSTERED ([AuditId])
);

-- CreateTable
CREATE TABLE [dbo].[Aufgaben] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [istAktiv] BIT,
    [MFIdentifier] NVARCHAR(max),
    [Faelligkeitsdatum] DATETIME2,
    [SchadenId] INT,
    CONSTRAINT [PK_Aufgaben] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Bankverbindung] (
    [Id] INT NOT NULL IDENTITY(1,1),
    CONSTRAINT [PK_Bankverbindung] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Bankverbindungen] (
    [BankverbindungId] INT NOT NULL IDENTITY(1,1),
    [BankName] NVARCHAR(max),
    [Iban] NVARCHAR(max),
    [Bic] NVARCHAR(max),
    [Zahlungstyp] NVARCHAR(max),
    [DienstleisterId] INT,
    [KundeTenantItemId] INT,
    [Zahlungsziel] INT NOT NULL,
    [SteuerNr] NVARCHAR(max),
    CONSTRAINT [PK_Bankverbindungen] PRIMARY KEY CLUSTERED ([BankverbindungId])
);

-- CreateTable
CREATE TABLE [dbo].[Benutzer] (
    [UserId] INT NOT NULL IDENTITY(1,1),
    [ObjectId] NVARCHAR(max),
    [Kundenname] NVARCHAR(max),
    [IstAktiv] BIT,
    [IstAktivGueltigAb] DATETIME2,
    [IstAktivGueltigBis] DATETIME2,
    [BenutzergruppeId] INT,
    [Benutzername] NVARCHAR(max),
    [KundeTenantItemId] INT NOT NULL CONSTRAINT [DF__Benutzer__KundeT__5708E33C] DEFAULT 0,
    CONSTRAINT [PK_Benutzer] PRIMARY KEY CLUSTERED ([UserId])
);

-- CreateTable
CREATE TABLE [dbo].[Benutzergruppen] (
    [BenutzergruppeId] INT NOT NULL IDENTITY(1,1),
    [Rolle] NVARCHAR(max),
    CONSTRAINT [PK_Benutzergruppen] PRIMARY KEY CLUSTERED ([BenutzergruppeId])
);

-- CreateTable
CREATE TABLE [dbo].[Benutzers] (
    [BenutzerId] INT NOT NULL IDENTITY(1,1),
    [VorundNachname] NVARCHAR(max),
    [Passwort] NVARCHAR(max),
    [StraBeundHausnummer] NVARCHAR(max),
    [PLZ] INT,
    [Ort] NVARCHAR(max),
    [zugehorigesUnternehmen] NVARCHAR(max),
    [Kennzeichen] NVARCHAR(max),
    [EMailAdresse] NVARCHAR(255),
    [Telefonnummer] NVARCHAR(max),
    [CountryCode] NVARCHAR(max),
    [IsEmail] BIT,
    [EmailCode] INT NOT NULL CONSTRAINT [DF__Benutzers__Email__55209ACA] DEFAULT 0,
    [UserId] INT NOT NULL CONSTRAINT [DF__Benutzers__UserI__5614BF03] DEFAULT 0,
    CONSTRAINT [PK_Benutzers] UNIQUE NONCLUSTERED ([BenutzerId]),
    CONSTRAINT [UQ__Benutzer__8507CAEF74A18878] UNIQUE NONCLUSTERED ([EMailAdresse]),
    CONSTRAINT [Benutzers_UserId_key] UNIQUE NONCLUSTERED ([UserId])
);

-- CreateTable
CREATE TABLE [dbo].[Beschaedigung] (
    [BeschaedigungId] INT NOT NULL IDENTITY(1,1),
    [Beschreibung] NVARCHAR(max),
    CONSTRAINT [PK_Beschaedigung] PRIMARY KEY CLUSTERED ([BeschaedigungId])
);

-- CreateTable
CREATE TABLE [dbo].[Buchungsposition] (
    [BuchungspositionId] INT NOT NULL IDENTITY(1,1),
    [BuchungsTyp] NVARCHAR(max) NOT NULL,
    [SchadenabwicklungBereich] NVARCHAR(max) NOT NULL,
    [Belegnummer] NVARCHAR(max),
    [Belegdatum] DATETIME2,
    [Buchungsdatum] DATETIME2,
    [Forderungsdatum] DATETIME2,
    [Buchungsbetrag] DECIMAL(18,2) NOT NULL,
    [Belegersteller] NVARCHAR(max),
    [Notiz] NVARCHAR(max),
    [SchadenId] INT NOT NULL,
    CONSTRAINT [PK_Buchungsposition] PRIMARY KEY CLUSTERED ([BuchungspositionId])
);

-- CreateTable
CREATE TABLE [dbo].[Bussgeld] (
    [BussgeldId] INT NOT NULL IDENTITY(1,1),
    [Aktenzeichen] NVARCHAR(max),
    [Kennzeichen] NVARCHAR(max),
    [Status] BIT NOT NULL,
    [Tatzeitpunkt] DATETIME2,
    [Eingangsdatum] DATETIME2,
    [Kommunikationsdatum] DATETIME2,
    [ZustaendigeBehoerde] NVARCHAR(max),
    [EMailBehoerde] NVARCHAR(max),
    [Zahlbescheid] BIT NOT NULL,
    [BussgeldHoehe] DECIMAL(18,2) NOT NULL,
    [KonkretesVergehen] NVARCHAR(max),
    [Art] NVARCHAR(max),
    [Kommentar] NVARCHAR(max),
    [FahrerId] INT NOT NULL,
    [KundeTenantItemId] INT NOT NULL,
    CONSTRAINT [PK_Bussgeld] PRIMARY KEY CLUSTERED ([BussgeldId])
);

-- CreateTable
CREATE TABLE [dbo].[ClaimDocument] (
    [ClaimDocumentExportId] INT NOT NULL IDENTITY(1,1),
    [CaseId] NVARCHAR(max),
    [AztIndex] INT,
    [CreatedOn] NVARCHAR(max),
    [ClaimNumber] NVARCHAR(max),
    [DocumentType] INT NOT NULL,
    [EventDate] NVARCHAR(max),
    [SparePartsDeduction] DECIMAL(18,2),
    [SparePartsDeductionValue] DECIMAL(18,2),
    [SummaryId] INT,
    [TimeUnitsPerHour] INT,
    [PaintingTimeUnitsPerHour] INT,
    [PaintingSystem] INT NOT NULL,
    [PostMasterId] INT,
    [VehicleId] INT,
    CONSTRAINT [PK_ClaimDocument] PRIMARY KEY CLUSTERED ([ClaimDocumentExportId])
);

-- CreateTable
CREATE TABLE [dbo].[ClaimDocumentExportAdditional] (
    [ClaimDocumentAdditionalId] INT NOT NULL IDENTITY(1,1),
    [Description] NVARCHAR(max),
    [IsManuallyModified] BIT NOT NULL,
    [Price] DECIMAL(18,2),
    [IsDMS] BIT NOT NULL,
    [Code] NVARCHAR(max),
    [Count] INT,
    [NumberOfTimeUnits] DECIMAL(18,2),
    [OemNumber] NVARCHAR(max),
    [ClaimDocumentExportId] INT,
    CONSTRAINT [PK_ClaimDocumentExportAdditional] PRIMARY KEY CLUSTERED ([ClaimDocumentAdditionalId])
);

-- CreateTable
CREATE TABLE [dbo].[ClaimDocumentExportClaimDocumentLabor] (
    [ClaimDocumentLaborId] INT NOT NULL IDENTITY(1,1),
    [Description] NVARCHAR(max),
    [IsManuallyModified] BIT NOT NULL,
    [Price] DECIMAL(18,2),
    [Code] NVARCHAR(max),
    [NumberOfTimeUnits] DECIMAL(18,2),
    [RepCode] NVARCHAR(max),
    [PositionNr] NVARCHAR(max),
    [ClassCode] NVARCHAR(max),
    [IsDMS] BIT NOT NULL,
    [ClaimDocumentExportId] INT,
    CONSTRAINT [PK_ClaimDocumentExportClaimDocumentLabor] PRIMARY KEY CLUSTERED ([ClaimDocumentLaborId])
);

-- CreateTable
CREATE TABLE [dbo].[ClaimDocumentExportClaimDocumentPainting] (
    [ClaimDocumentPaintingId] INT NOT NULL IDENTITY(1,1),
    [Description] NVARCHAR(max),
    [IsManuallyModified] BIT NOT NULL,
    [Price] DECIMAL(18,2),
    [MaterialPoints] DECIMAL(18,2),
    [Code] NVARCHAR(max),
    [NumberOfTimeUnits] DECIMAL(18,2),
    [RepCode] NVARCHAR(max),
    [PositionNr] NVARCHAR(max),
    [ClassCode] NVARCHAR(max),
    [IsDMS] BIT NOT NULL,
    [ClaimDocumentExportId] INT,
    CONSTRAINT [PK_ClaimDocumentExportClaimDocumentPainting] PRIMARY KEY CLUSTERED ([ClaimDocumentPaintingId])
);

-- CreateTable
CREATE TABLE [dbo].[ClaimDocumentExportClaimDocumentSparePart] (
    [ClaimDocumentSparePartId] INT NOT NULL IDENTITY(1,1),
    [Amount] DECIMAL(18,2),
    [UnitPrice] DECIMAL(18,2),
    [Description] NVARCHAR(max),
    [IsManuallyModified] BIT NOT NULL,
    [Price] DECIMAL(18,2),
    [Code] NVARCHAR(max),
    [Count] INT,
    [OemNumber] NVARCHAR(max),
    [IsDMS] BIT NOT NULL,
    [ClaimDocumentExportId] INT,
    CONSTRAINT [PK_ClaimDocumentExportClaimDocumentSparePart] PRIMARY KEY CLUSTERED ([ClaimDocumentSparePartId])
);

-- CreateTable
CREATE TABLE [dbo].[ClaimDocumentExportPaintingMaterial] (
    [ClaimDocumentPaintingMaterialId] INT NOT NULL IDENTITY(1,1),
    [Description] NVARCHAR(max),
    [IsManuallyModified] BIT NOT NULL,
    [Price] DECIMAL(18,2),
    [ClaimDocumentExportId] INT,
    CONSTRAINT [PK_ClaimDocumentExportPaintingMaterial] PRIMARY KEY CLUSTERED ([ClaimDocumentPaintingMaterialId])
);

-- CreateTable
CREATE TABLE [dbo].[ClaimDocumentExportPostMaster] (
    [PostMasterId] INT NOT NULL IDENTITY(1,1),
    [Comment] NVARCHAR(max),
    [RepairDuration] INT NOT NULL,
    CONSTRAINT [PK_ClaimDocumentExportPostMaster] PRIMARY KEY CLUSTERED ([PostMasterId])
);

-- CreateTable
CREATE TABLE [dbo].[ClaimDocumentExportSummary] (
    [SummaryId] INT NOT NULL IDENTITY(1,1),
    [AdditionalCost] DECIMAL(18,2),
    [LaborCost] DECIMAL(18,2),
    [LaborCost1] DECIMAL(18,2),
    [LaborCost2] DECIMAL(18,2),
    [LaborCost3] DECIMAL(18,2),
    [LaborNumberOfTimeUnits] DECIMAL(18,2),
    [LaborRate1] DECIMAL(18,2),
    [LaborRate2] DECIMAL(18,2),
    [LaborRate3] DECIMAL(18,2),
    [NetCost] DECIMAL(18,2),
    [PaintingCost] DECIMAL(18,2),
    [PaintingLaborCost] DECIMAL(18,2),
    [PaintingMaterialCost] DECIMAL(18,2),
    [PaintingRate] DECIMAL(18,2),
    [PaintingTimeUnits] DECIMAL(18,2),
    [SmallSparePartsCost] DECIMAL(18,2),
    [SmallSparePartsPercentage] DECIMAL(18,2),
    [SparePartsCost] DECIMAL(18,2),
    [TaxRate] DECIMAL(18,2),
    [TaxValue] DECIMAL(18,2),
    [TotalCost] DECIMAL(18,2),
    [UsedPartsTaxPositionsValue] DECIMAL(18,2),
    [UsedPartsTaxRate] DECIMAL(18,2),
    [UsedPartsTaxValue] DECIMAL(18,2),
    CONSTRAINT [PK_ClaimDocumentExportSummary] PRIMARY KEY CLUSTERED ([SummaryId])
);

-- CreateTable
CREATE TABLE [dbo].[ClaimDocumentExportVehicle] (
    [VehicleId] INT NOT NULL IDENTITY(1,1),
    [Brand] NVARCHAR(max),
    [EngineCapacity] NVARCHAR(max),
    [EnginePowerKW] NVARCHAR(max),
    [FirstRegistrationDate] NVARCHAR(max),
    [Mileage] NVARCHAR(max),
    [Model] NVARCHAR(max),
    [Paint] INT NOT NULL,
    [RegistrationNumber] NVARCHAR(max),
    [Submodel] NVARCHAR(max),
    [VIN] NVARCHAR(max),
    CONSTRAINT [PK_ClaimDocumentExportVehicle] PRIMARY KEY CLUSTERED ([VehicleId])
);

-- CreateTable
CREATE TABLE [dbo].[ClaimDocumentLabor] (
    [ClaimDocumentLaborId] INT NOT NULL IDENTITY(1,1),
    [Description] NVARCHAR(max) NOT NULL,
    [IsManuallyModified] BIT NOT NULL,
    [Price] DECIMAL(18,2),
    [Code] NVARCHAR(max) NOT NULL,
    [NumberOfTimeUnits] DECIMAL(18,2),
    [RepCode] NVARCHAR(max) NOT NULL,
    [PositionNr] NVARCHAR(max) NOT NULL,
    [ClassCode] NVARCHAR(max) NOT NULL,
    [IsDMS] BIT NOT NULL,
    CONSTRAINT [PK_ClaimDocumentLabor] PRIMARY KEY CLUSTERED ([ClaimDocumentLaborId])
);

-- CreateTable
CREATE TABLE [dbo].[ClaimDocumentPainting] (
    [ClaimDocumentPaintingId] INT NOT NULL IDENTITY(1,1),
    [Description] NVARCHAR(max) NOT NULL,
    [IsManuallyModified] BIT NOT NULL,
    [Price] DECIMAL(18,2),
    [MaterialPoints] DECIMAL(18,2),
    [Code] NVARCHAR(max) NOT NULL,
    [NumberOfTimeUnits] DECIMAL(18,2),
    [RepCode] NVARCHAR(max) NOT NULL,
    [PositionNr] NVARCHAR(max) NOT NULL,
    [ClassCode] NVARCHAR(max) NOT NULL,
    [IsDMS] BIT NOT NULL,
    CONSTRAINT [PK_ClaimDocumentPainting] PRIMARY KEY CLUSTERED ([ClaimDocumentPaintingId])
);

-- CreateTable
CREATE TABLE [dbo].[ClaimDocumentPaintingMaterial] (
    [ClaimDocumentPaintingMaterialId] INT NOT NULL IDENTITY(1,1),
    [Description] NVARCHAR(max) NOT NULL,
    [IsManuallyModified] BIT NOT NULL,
    [Price] DECIMAL(18,2),
    CONSTRAINT [PK_ClaimDocumentPaintingMaterial] PRIMARY KEY CLUSTERED ([ClaimDocumentPaintingMaterialId])
);

-- CreateTable
CREATE TABLE [dbo].[ClaimDocumentSparePart] (
    [ClaimDocumentSparePartId] INT NOT NULL IDENTITY(1,1),
    [Amount] DECIMAL(18,2),
    [UnitPrice] DECIMAL(18,2),
    [Description] NVARCHAR(max) NOT NULL,
    [IsManuallyModified] BIT,
    [Price] DECIMAL(18,2),
    [Code] NVARCHAR(max),
    [Count] INT,
    [OemNumber] NVARCHAR(max),
    [IsDMS] BIT,
    CONSTRAINT [PK_ClaimDocumentSparePart] PRIMARY KEY CLUSTERED ([ClaimDocumentSparePartId])
);

-- CreateTable
CREATE TABLE [dbo].[DataFieldConfigs] (
    [DataFieldConfigId] INT NOT NULL IDENTITY(1,1),
    [ImpactedDataFields] NVARCHAR(max),
    [SourceEntity] NVARCHAR(max),
    [Delimiter] NVARCHAR(max),
    [FirstDataField] NVARCHAR(max),
    [SecondDataField] NVARCHAR(max),
    [ImportTemplateTemplateId] INT NOT NULL CONSTRAINT [DF__DataField__Impor__6497E884] DEFAULT 0,
    [Operation] NVARCHAR(max),
    [FromWordNumber] INT,
    [TillWordNumber] INT,
    CONSTRAINT [PK_DataFieldConfigs] PRIMARY KEY CLUSTERED ([DataFieldConfigId])
);

-- CreateTable
CREATE TABLE [dbo].[DbFieldMapping] (
    [DbFieldMappingId] INT NOT NULL IDENTITY(1,1),
    [DocumentField] NVARCHAR(max),
    [DatabaseTableName] NVARCHAR(max),
    [DatabaseColumnName] NVARCHAR(max),
    [DatabaseColumnType] NVARCHAR(max),
    [IsRequired] BIT,
    [IsDatabaseColumnId] BIT,
    [DefaultValue] NVARCHAR(max),
    [DbModelId] INT NOT NULL,
    [IsForeignKey] BIT,
    [IsPrimaryKey] BIT,
    [Culturestring] NVARCHAR(max),
    [Confidence] REAL,
    CONSTRAINT [PK_DbFieldMapping] PRIMARY KEY CLUSTERED ([DbFieldMappingId])
);

-- CreateTable
CREATE TABLE [dbo].[DbModels] (
    [DbModelId] INT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(max),
    [DocumentId] NVARCHAR(max),
    [ApiVersion] NVARCHAR(max),
    [Guid] NVARCHAR(max),
    [ModelType] NVARCHAR(max),
    [ContainerName] NVARCHAR(max),
    [Quality] FLOAT(53),
    [IsActive] BIT NOT NULL,
    [ReferenceBlobName] NVARCHAR(max),
    [ZielAnwendung] NVARCHAR(max),
    [ZielFormat] NVARCHAR(max),
    CONSTRAINT [PK_DbModels] PRIMARY KEY CLUSTERED ([DbModelId])
);

-- CreateTable
CREATE TABLE [dbo].[DbTableConfig] (
    [DbTableConfigId] INT NOT NULL IDENTITY(1,1),
    [TableName] NVARCHAR(max),
    [TableDescription] NVARCHAR(max),
    [DatastoreTableMapping] NVARCHAR(max),
    [Active] BIT NOT NULL,
    [BlobName] NVARCHAR(max),
    [ModelId] INT NOT NULL,
    [ModelName] NVARCHAR(max),
    [CultureString] NVARCHAR(max),
    [RunningTable] BIT NOT NULL,
    [DbModelId] INT NOT NULL,
    CONSTRAINT [PK_DbTableConfig] PRIMARY KEY CLUSTERED ([DbTableConfigId])
);

-- CreateTable
CREATE TABLE [dbo].[DbTableMapping] (
    [DbTableMappingId] INT NOT NULL IDENTITY(1,1),
    [DocumentTableColumnName] NVARCHAR(max),
    [DatabaseTableName] NVARCHAR(max),
    [DatabaseTableColumnName] NVARCHAR(max),
    [DatabaseTableColumnType] NVARCHAR(max),
    [IsRequired] BIT,
    [IsDatabaseColumnId] BIT,
    [DefaultValue] NVARCHAR(max),
    [DbTableConfigId] INT NOT NULL,
    [IsForeignKey] BIT,
    [IsPrimaryKey] BIT,
    [Culture] NVARCHAR(max),
    [DocumentTableConfidence] FLOAT(53),
    CONSTRAINT [PK_DbTableMapping] PRIMARY KEY CLUSTERED ([DbTableMappingId])
);

-- CreateTable
CREATE TABLE [dbo].[Dienstleister] (
    [DienstleisterId] INT NOT NULL IDENTITY(1,1),
    [Schluessel] NVARCHAR(max),
    [Name] NVARCHAR(max),
    [IstAktiv] BIT,
    [IstAktivGueltigAb] DATETIME2,
    [IstAktivGueltigBis] DATETIME2,
    [Dienstleisterart] NVARCHAR(max),
    [Matchcode] NVARCHAR(max),
    [Anmerkungen] NVARCHAR(max),
    [NoxDepot] BIT NOT NULL CONSTRAINT [DF__Dienstlei__NoxDe__613C58EC] DEFAULT CONVERT([bit],(0)),
    [Favorit] INT,
    [Gewerbenachweis] BIT NOT NULL CONSTRAINT [DF__Dienstlei__Gewer__604834B3] DEFAULT CONVERT([bit],(0)),
    [Teileservice] BIT NOT NULL CONSTRAINT [DF__Dienstlei__Teile__52793849] DEFAULT CONVERT([bit],(0)),
    [AusserDienstBis] DATETIME2,
    [AusserDienstVon] DATETIME2,
    [InaktivGrund] NVARCHAR(max),
    [Dlp] DECIMAL(18,2),
    [Et] DECIMAL(18,2),
    [RueckverguetungEt] DECIMAL(18,2),
    [AnzahlBuehnen] INT NOT NULL CONSTRAINT [DF__Dienstlei__Anzah__536D5C82] DEFAULT 0,
    [Niederlassung] NVARCHAR(max),
    [NseDepot] BIT NOT NULL CONSTRAINT [DF__Dienstlei__NseDe__546180BB] DEFAULT CONVERT([bit],(0)),
    [SteuerNummer] NVARCHAR(max),
    [UmsatzSteuerIdentNummer] NVARCHAR(max),
    [Verwendungsnachweis] BIT NOT NULL CONSTRAINT [DF__Dienstlei__Verwe__5555A4F4] DEFAULT CONVERT([bit],(0)),
    CONSTRAINT [PK_Dienstleister] PRIMARY KEY CLUSTERED ([DienstleisterId])
);

-- CreateTable
CREATE TABLE [dbo].[DienstleisterTypen] (
    [DienstleisterTypId] INT NOT NULL IDENTITY(1,1),
    [Bezeichnung] NVARCHAR(max),
    CONSTRAINT [PK_DienstleisterTypen] PRIMARY KEY CLUSTERED ([DienstleisterTypId])
);

-- CreateTable
CREATE TABLE [dbo].[Dienstleistungspauschalen] (
    [DienstleistungspauschaleId] INT NOT NULL IDENTITY(1,1),
    [DienstleisterArt] NVARCHAR(max) NOT NULL,
    [Dlp] DECIMAL(18,2) NOT NULL CONSTRAINT [DEFAULT_Dienstleistungspauschalen_Dlp] DEFAULT 0,
    [Et] DECIMAL(18,2) NOT NULL CONSTRAINT [DEFAULT_Dienstleistungspauschalen_Et] DEFAULT 0,
    [RueckverguetungEt] DECIMAL(18,2) NOT NULL CONSTRAINT [DEFAULT_Dienstleistungspauschalen_RueckverguetungEt] DEFAULT 0,
    [KundeTenantItemId] INT,
    [DienstleisterId] INT NOT NULL CONSTRAINT [DF__Dienstlei__Diens__48EFCE0F] DEFAULT 0,
    CONSTRAINT [PK_Dienstleistungspauschalen] PRIMARY KEY CLUSTERED ([DienstleistungspauschaleId])
);

-- CreateTable
CREATE TABLE [dbo].[DriversCheckCheckups] (
    [DriversCheckCheckupId] INT NOT NULL IDENTITY(1,1),
    [DriversCheckFskId] INT NOT NULL CONSTRAINT [DF__DriversCh__Drive__71F1E3A2] DEFAULT 0,
    [DriversCheckFuId] INT NOT NULL CONSTRAINT [DF__DriversCh__Drive__70FDBF69] DEFAULT 0,
    CONSTRAINT [PK_DriversCheckCheckups] PRIMARY KEY CLUSTERED ([DriversCheckCheckupId])
);

-- CreateTable
CREATE TABLE [dbo].[DriversCheckDriverLicenses] (
    [DriversCheckDriverLicenseId] INT NOT NULL IDENTITY(1,1),
    [tagNumber] NVARCHAR(max),
    [licenseNumber] NVARCHAR(max),
    [licenseValidUntil] NVARCHAR(max),
    [DrivingLicenseClasses] NVARCHAR(max),
    [Restrictions] NVARCHAR(max),
    CONSTRAINT [PK_DriversCheckDriverLicenses] PRIMARY KEY CLUSTERED ([DriversCheckDriverLicenseId])
);

-- CreateTable
CREATE TABLE [dbo].[DriversCheckEmployees] (
    [DriversCheckEmployeeId] INT NOT NULL IDENTITY(1,1),
    [organisationId] NVARCHAR(max),
    [salutation] NVARCHAR(max),
    [lastname] NVARCHAR(max),
    [firstname] NVARCHAR(max),
    [birthday] NVARCHAR(max),
    [personnelNumber] NVARCHAR(max),
    [department] NVARCHAR(max),
    [costCenter] NVARCHAR(max),
    [licensePlate] NVARCHAR(max),
    [note] NVARCHAR(max),
    [mobilePhone] NVARCHAR(max),
    [email] NVARCHAR(max),
    [superiorEmail] NVARCHAR(max),
    [checkupInterval] INT NOT NULL,
    [FUCourseId] INT NOT NULL,
    [active] BIT NOT NULL,
    [created] DATETIME2 NOT NULL,
    [updated] DATETIME2 NOT NULL,
    [DriversCheckDriverLicenseId] INT,
    [DriversCheckPrivilegesId] INT,
    [DriversCheckModulesId] INT,
    [DriversCheckCheckupId] INT,
    [FahrerId] INT NOT NULL CONSTRAINT [DF__DriversCh__Fahre__5DEAEAF5] DEFAULT 0,
    CONSTRAINT [PK_DriversCheckEmployees] PRIMARY KEY CLUSTERED ([DriversCheckEmployeeId])
);

-- CreateTable
CREATE TABLE [dbo].[DriversCheckFsks] (
    [DriversCheckFskId] INT NOT NULL IDENTITY(1,1),
    [checkupInterval] INT NOT NULL,
    [lastCheckup] NVARCHAR(max),
    [nextCheckup] NVARCHAR(max),
    [validCheckup] BIT NOT NULL,
    CONSTRAINT [PK_DriversCheckFsks] PRIMARY KEY CLUSTERED ([DriversCheckFskId])
);

-- CreateTable
CREATE TABLE [dbo].[DriversCheckFus] (
    [DriversCheckFuId] INT NOT NULL IDENTITY(1,1),
    [checkupInterval] INT NOT NULL,
    [lastCheckup] NVARCHAR(max),
    [nextCheckup] NVARCHAR(max),
    [validCheckup] BIT NOT NULL,
    CONSTRAINT [PK_DriversCheckFus] PRIMARY KEY CLUSTERED ([DriversCheckFuId])
);

-- CreateTable
CREATE TABLE [dbo].[DriversCheckModules] (
    [DriversCheckModulesId] INT NOT NULL IDENTITY(1,1),
    [FSK] BIT NOT NULL,
    [VIA] BIT NOT NULL,
    [FU] BIT NOT NULL,
    CONSTRAINT [PK_DriversCheckModules] PRIMARY KEY CLUSTERED ([DriversCheckModulesId])
);

-- CreateTable
CREATE TABLE [dbo].[DriversCheckOrganizationCheckups] (
    [DriversCheckOrganizationCheckupId] INT NOT NULL IDENTITY(1,1),
    [checkupInterval] INT NOT NULL,
    [checkupTimeslot] INT NOT NULL,
    [firstReminder] INT NOT NULL,
    [secondReminder] INT NOT NULL,
    [thirdReminder] INT NOT NULL,
    CONSTRAINT [PK_DriversCheckOrganizationCheckups] PRIMARY KEY CLUSTERED ([DriversCheckOrganizationCheckupId])
);

-- CreateTable
CREATE TABLE [dbo].[DriversCheckOrganizations] (
    [DriversCheckOrganizationId] INT NOT NULL IDENTITY(1,1),
    [uuid] NVARCHAR(max),
    [parentId] NVARCHAR(max),
    [name] NVARCHAR(max),
    [supportEmail] NVARCHAR(max),
    [addressContactPerson] NVARCHAR(max),
    [billRecipient] NVARCHAR(max),
    [benefitRecipient] NVARCHAR(max),
    [billByEmail] BIT NOT NULL,
    [billEmail] NVARCHAR(max),
    [billReportByEmail] BIT NOT NULL,
    [billReportEmail] NVARCHAR(max),
    [selfCheckupAccepted] BIT NOT NULL,
    [assignmentByChecker] BIT NOT NULL,
    [visualCheckByChecker] BIT NOT NULL,
    [created] NVARCHAR(max),
    [updated] NVARCHAR(max),
    [DriversCheckOrganizationCheckupId] INT,
    CONSTRAINT [PK_DriversCheckOrganizations] PRIMARY KEY CLUSTERED ([DriversCheckOrganizationId])
);

-- CreateTable
CREATE TABLE [dbo].[DriversCheckPrivileges] (
    [DriversCheckPrivilegesId] INT NOT NULL IDENTITY(1,1),
    [driver] BIT NOT NULL,
    [checker] BIT NOT NULL,
    [fleetManager] BIT NOT NULL,
    [admin] BIT NOT NULL,
    CONSTRAINT [PK_DriversCheckPrivileges] PRIMARY KEY CLUSTERED ([DriversCheckPrivilegesId])
);

-- CreateTable
CREATE TABLE [dbo].[EnterpriseContracts] (
    [EnterpriseContractId] INT NOT NULL IDENTITY(1,1),
    [Schadennummer] NVARCHAR(max),
    [BranchOfficeAddress] NVARCHAR(max),
    [BranchOfficeTelephone] NVARCHAR(max),
    [ContractConfirmationNumber] NVARCHAR(max),
    [RenterFirstname] NVARCHAR(max),
    [RenterLastname] NVARCHAR(max),
    [RenterTelephone] NVARCHAR(max),
    [ContractNumber] NVARCHAR(max),
    [AuthNumberOfDays] INT NOT NULL CONSTRAINT [DF__Enterpris__AuthN__7E8CC4B1] DEFAULT 0,
    [BranchId] NVARCHAR(max),
    [EffectiveNumberOfDays] INT NOT NULL CONSTRAINT [DF__Enterpris__Effec__7F80E8EA] DEFAULT 0,
    [LastAuthDate] DATETIME2,
    [PickupDate] DATETIME2,
    [ReturnDate] DATETIME2,
    [VehicleClass] NVARCHAR(max),
    [VehicleLicensePlate] NVARCHAR(max),
    [ContractStatus] NVARCHAR(max),
    [TransmissionDateTime] DATETIME2,
    [ReturnMethod] NVARCHAR(max),
    [RenterEmail] NVARCHAR(max),
    [VehicleMake] NVARCHAR(max),
    [VehicleModel] NVARCHAR(max),
    [PickupCity] NVARCHAR(max),
    [PickupCountry] NVARCHAR(max),
    [PickupCountryCode] NVARCHAR(max),
    [PickupPhone] NVARCHAR(max),
    [PickupPostalCode] NVARCHAR(max),
    [PickupStreet] NVARCHAR(max),
    [PickupType] NVARCHAR(max),
    [ReturnCity] NVARCHAR(max),
    [ReturnCountry] NVARCHAR(max),
    [ReturnCountryCode] NVARCHAR(max),
    [ReturnPhone] NVARCHAR(max),
    [ReturnPostalCode] NVARCHAR(max),
    [ReturnStreet] NVARCHAR(max),
    [ReturnType] NVARCHAR(max),
    [Mileage] NVARCHAR(max),
    [PickupEmail] NVARCHAR(max),
    [PickupName] NVARCHAR(max),
    [VehicleOutDate] NVARCHAR(max),
    [VehicleYear] NVARCHAR(max),
    [Vin] NVARCHAR(max),
    [DataExchangeRecordId] INT NOT NULL CONSTRAINT [DF__Enterpris__DataE__119F9925] DEFAULT 0,
    [TransactionId] NVARCHAR(max),
    [AdditionalDays] INT,
    [BranchOfficeEmail] NVARCHAR(max),
    [BranchOfficeLocation] NVARCHAR(max),
    [BranchOfficeStateDescription] NVARCHAR(max),
    [BranchOfficeZipcode] NVARCHAR(max),
    [ClaimDate] DATETIME2,
    [Company] NVARCHAR(max),
    [ContractStatusDescription] NVARCHAR(max),
    [OfficeId] NVARCHAR(max),
    [RenterLocation] NVARCHAR(max),
    [RenterStreet] NVARCHAR(max),
    [RenterZipcode] NVARCHAR(max),
    [ReturnName] NVARCHAR(max),
    CONSTRAINT [PK_EnterpriseContracts] PRIMARY KEY CLUSTERED ([EnterpriseContractId])
);

-- CreateTable
CREATE TABLE [dbo].[EnumImportConfigs] (
    [EnumImportConfigId] INT NOT NULL IDENTITY(1,1),
    [EnumType] NVARCHAR(max),
    [EnumValue] NVARCHAR(max),
    [SourceValue] NVARCHAR(max),
    [ImportTemplateTemplateId] INT NOT NULL CONSTRAINT [DF__EnumImpor__Impor__1E05700A] DEFAULT 0,
    CONSTRAINT [PK_EnumImportConfigs] PRIMARY KEY CLUSTERED ([EnumImportConfigId])
);

-- CreateTable
CREATE TABLE [dbo].[Ersatzteil] (
    [ErsatzteilId] INT NOT NULL IDENTITY(1,1),
    [Bezeichnung] NVARCHAR(max),
    [PositionStatus] INT NOT NULL,
    [GesamtpreisAusKv] DECIMAL(18,2) NOT NULL,
    [GesamtpreisFinal] DECIMAL(18,2) NOT NULL,
    [KostenvoranschlagId] INT NOT NULL,
    [UniqueKvId] NVARCHAR(max),
    [AnzahlAusKv] INT NOT NULL CONSTRAINT [DF__Ersatztei__Anzah__60283922] DEFAULT 0,
    [AnzahlFinal] INT NOT NULL CONSTRAINT [DF__Ersatztei__Anzah__611C5D5B] DEFAULT 0,
    [EinzelpreisAusKv] DECIMAL(18,2) NOT NULL CONSTRAINT [DF__Ersatztei__Einze__62108194] DEFAULT 0.0,
    [EinzelpreisFinal] DECIMAL(18,2) NOT NULL CONSTRAINT [DF__Ersatztei__Einze__6304A5CD] DEFAULT 0.0,
    [OemNummer] NVARCHAR(max),
    [Bemerkung] NVARCHAR(max),
    [DVN] NVARCHAR(max),
    [ETN] NVARCHAR(max),
    [RC] NVARCHAR(max),
    [Eingangszeit] DATETIME2 NOT NULL CONSTRAINT [DF__Ersatztei__Einga__1A34DF26] DEFAULT 0001-01-01T00:00:00.0000000,
    CONSTRAINT [PK_Ersatzteil] PRIMARY KEY CLUSTERED ([ErsatzteilId])
);

-- CreateTable
CREATE TABLE [dbo].[Event] (
    [EventId] INT NOT NULL IDENTITY(1,1),
    [EventName] NVARCHAR(max),
    [EventActivation] NVARCHAR(max),
    [EventOperation] NVARCHAR(max),
    CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED ([EventId])
);

-- CreateTable
CREATE TABLE [dbo].[Fahrer] (
    [FahrerId] INT NOT NULL IDENTITY(1,1),
    [Anrede] INT NOT NULL,
    [Vorname] NVARCHAR(max),
    [Nachname] NVARCHAR(max) NOT NULL,
    [KompletterName] NVARCHAR(max),
    [Zusatz] NVARCHAR(max),
    [Geburtsdatum] DATETIME2,
    [Fahrerlaubnis] NVARCHAR(max),
    [Fahrerklasse] NVARCHAR(max),
    [Kostenstelle1] NVARCHAR(max),
    [Kostenstelle2] NVARCHAR(max),
    [Kostenstelle1G├╝ltigAb] DATETIME2,
    [Kostenstelle2G├╝ltigAb] DATETIME2,
    [NutzerVon] DATETIME2,
    [NutzerBis] DATETIME2,
    [DatumF├╝hrerschein] DATETIME2,
    [IstAktiv] BIT,
    [IstAktivGueltigAb] DATETIME2,
    [IstAktivGueltigBis] DATETIME2,
    [EntfernungWohnungZuArbeitsplatz] INT,
    [EntfernungWohnungZuArbeitsplatzG├╝ltigAb] DATETIME2,
    [Abteilung] NVARCHAR(max),
    [Position] NVARCHAR(max),
    [Vorgesetzter] NVARCHAR(max),
    [Unternehmenszuschuss] FLOAT(53),
    [KontaktPersonalabteilung] NVARCHAR(max),
    [AkademischerGrad] NVARCHAR(max),
    [Personalnummer] NVARCHAR(max),
    [LetzteUnfallverh├╝tungsvorschriftKontrolle] DATETIME2,
    [NaechsteUnfallverh├╝tungsvorschriftKontrolle] DATETIME2,
    [LetzteFahrerunterweisung] DATETIME2,
    [NaechsteFahrerunterweisung] DATETIME2,
    [LetzteFuehrerscheinKontrolle] DATETIME2,
    [NaechsteFuehrerscheinkontrolle] DATETIME2,
    [InNuceFahrerNummer] INT,
    [KundeTenantItemId] INT,
    [FahrzeugTenantItemId] INT,
    [FahrerklasseName] NVARCHAR(max),
    [ExternalDataField] VARCHAR(max),
    [DriverCheckId] NVARCHAR(max),
    CONSTRAINT [PK_Fahrer] PRIMARY KEY CLUSTERED ([FahrerId])
);

-- CreateTable
CREATE TABLE [dbo].[FahrerFahrzeug] (
    [FahrerId] INT NOT NULL,
    [FahrzeugeTenantItemId] INT NOT NULL,
    [PublicationDate] DATETIME2 NOT NULL CONSTRAINT [DF__FahrerFah__Publi__09FE775D] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [PK_FahrerFahrzeug] PRIMARY KEY CLUSTERED ([FahrerId],[FahrzeugeTenantItemId])
);

-- CreateTable
CREATE TABLE [dbo].[Fahrerklasse] (
    [FahrerklasseId] INT NOT NULL IDENTITY(1,1),
    [TenantItemId] INT NOT NULL,
    [FahrerklasseName] NVARCHAR(max),
    [inNuceFahrerklasseId] NVARCHAR(max),
    [FahrerklasseG├╝ltigAb] DATETIME2,
    [FahrerklasseG├╝ltigBis] DATETIME2,
    [Status] BIT,
    [FahrerId] INT NOT NULL,
    CONSTRAINT [PK_Fahrerklasse] PRIMARY KEY CLUSTERED ([FahrerklasseId])
);

-- CreateTable
CREATE TABLE [dbo].[Fahrzeugbelege] (
    [FahrzeugbelegId] INT NOT NULL IDENTITY(1,1),
    [Belegdatum] DATETIME2 NOT NULL,
    [BelegerstellerDienstleisterId] INT,
    [FahrzeugTenantItemId] INT NOT NULL CONSTRAINT [DF__Fahrzeugb__Fahrz__7D98A078] DEFAULT 0,
    [Bezeichnung] NVARCHAR(max),
    [Belegnummer] NVARCHAR(max),
    [KmStand] FLOAT(53),
    [SteuerNeutral] BIT NOT NULL CONSTRAINT [DF__Fahrzeugb__Steue__7E8CC4B1] DEFAULT CONVERT([bit],(0)),
    CONSTRAINT [PK_Fahrzeugbelege] PRIMARY KEY CLUSTERED ([FahrzeugbelegId])
);

-- CreateTable
CREATE TABLE [dbo].[FahrzeugbelegKategorien] (
    [FahrzeugbelegKategorieId] INT NOT NULL IDENTITY(1,1),
    [Bezeichnung] NVARCHAR(max),
    [FahrzeugbelegKategorieTypId] INT,
    CONSTRAINT [PK_FahrzeugbelegKategorien] PRIMARY KEY CLUSTERED ([FahrzeugbelegKategorieId])
);

-- CreateTable
CREATE TABLE [dbo].[FahrzeugbelegKategorieTypen] (
    [FahrzeugbelegKategorieTypId] INT NOT NULL IDENTITY(1,1),
    [Bezeichnung] NVARCHAR(max),
    [SubTyp] NVARCHAR(max),
    CONSTRAINT [PK_FahrzeugbelegKategorieTypen] PRIMARY KEY CLUSTERED ([FahrzeugbelegKategorieTypId])
);

-- CreateTable
CREATE TABLE [dbo].[Fahrzeugbelegpositionen] (
    [FahrzeugbelegpositionId] INT NOT NULL IDENTITY(1,1),
    [Menge] INT NOT NULL,
    [Einzelpreis] DECIMAL(18,2) NOT NULL,
    [Gesamtpreis] DECIMAL(18,2) NOT NULL,
    [Hinweise] NVARCHAR(max),
    [FahrzeugbelegId] INT NOT NULL CONSTRAINT [DF__Fahrzeugb__Fahrz__731B1205] DEFAULT 0,
    [FahrzeugbelegpositionsBezeichnungId] INT,
    [FaelligkeitText] NVARCHAR(max),
    [NaechsteFaelligkeit] DATETIME2,
    [Zahlweise] NVARCHAR(max),
    [FahrzeugbelegKategorieId] INT,
    [FahrzeugbelegKategorie] NVARCHAR(max),
    [FahrzeugbelegKategorieSubTyp] NVARCHAR(max),
    [FahrzeugbelegKategorieTyp] NVARCHAR(max),
    CONSTRAINT [PK_Fahrzeugbelegpositionen] PRIMARY KEY CLUSTERED ([FahrzeugbelegpositionId])
);

-- CreateTable
CREATE TABLE [dbo].[FahrzeugbelegpositionsBezeichnungen] (
    [FahrzeugbelegpositionsBezeichnungId] INT NOT NULL IDENTITY(1,1),
    [Bezeichnung] NVARCHAR(max),
    CONSTRAINT [PK_FahrzeugbelegpositionsBezeichnungen] PRIMARY KEY CLUSTERED ([FahrzeugbelegpositionsBezeichnungId])
);

-- CreateTable
CREATE TABLE [dbo].[Fahrzeuge] (
    [TenantItemId] INT NOT NULL IDENTITY(1,1),
    [Kennzeichen] NVARCHAR(max) NOT NULL,
    [KennzeichenGueltigAb] DATETIME2,
    [Fin] NVARCHAR(max),
    [Name] NVARCHAR(max),
    [Erstzulassung] DATETIME2,
    [Laufleistung] INT,
    [Fahrzeugstatus] NVARCHAR(max) NOT NULL,
    [FahrzeugstatusGueltigAb] DATETIME2,
    [LetzteZulassung] DATETIME2,
    [Kostenstelle1] NVARCHAR(max),
    [Kostenstelle2] NVARCHAR(max),
    [Kostenstelle1GueltigAb] DATETIME2,
    [Kostenstelle2GueltigAb] DATETIME2,
    [Beschreibung1] NVARCHAR(max),
    [Beschreibung2] NVARCHAR(max),
    [Autofarbe] NVARCHAR(max),
    [Polsterfarbe] NVARCHAR(max),
    [InNuceFahrzeugNummer] INT,
    [InNuceKndNr] NVARCHAR(max),
    [LieferantDienstleisterId] INT,
    [KaufvertragId] INT,
    [MietvertragId] INT,
    [LeasingvertragId] INT,
    [KundeTenantItemId] INT NOT NULL,
    [Nettolistenpreis] FLOAT(53),
    [NettoSonderausstattungPreis] FLOAT(53),
    [NachtraeglichesZubehoerPreis] FLOAT(53),
    [Bruttolistenpreis] FLOAT(53),
    [Bruttolistenpreis_fuer_den_GwV] FLOAT(53),
    [Gesamtpreis] FLOAT(53),
    [KfzSteuer] FLOAT(53),
    [KfzSteuernummer] NVARCHAR(max),
    [ExternalId] NVARCHAR(max),
    [KennzeichenAnh├ñnger] NVARCHAR(max),
    [Anmerkungen] NVARCHAR(max),
    [Dienstleisternummer] NVARCHAR(max),
    [DienstleisterName] NVARCHAR(max),
    [Erzeuger] NVARCHAR(max),
    [Eingang] DATETIME2,
    [Bestellung] NVARCHAR(max),
    [BestellZeitinTagen] NVARCHAR(max),
    [UnverbindlicherLiefertermin] DATETIME2,
    [Lieferung] DATETIME2,
    [LieferzeitInTagen] NVARCHAR(max),
    [Rueckgabe] DATETIME2,
    [LetzterKilometerstand_Anzahl] INT,
    [LetzterKilometerstand_Tag] DATETIME2,
    [ErsterKilometerstand_Anzahl] INT,
    [ErsterKilometerstand_Tag] DATETIME2,
    [GefahreneKilometer] INT,
    [Anlagennummer] INT,
    [AFA] INT,
    [Buchwert] INT,
    [Leistung10erBereich] NVARCHAR(max),
    [Leistung20erBereich] NVARCHAR(max),
    [Hersteller] NVARCHAR(max),
    [Modell] NVARCHAR(max),
    [Typ] NVARCHAR(max),
    [TypschluesselDatenlieferant] NVARCHAR(max),
    [TypschluesselInNuce] NVARCHAR(max),
    [Fahrzeugart] NVARCHAR(max),
    [PoolFahrzeug] BIT,
    [Produktionsbeginn] DATETIME2,
    [Produktionsende] DATETIME2,
    [HerstellerBestellCode] NVARCHAR(max),
    [Tsn] NVARCHAR(max),
    [Hsn] NVARCHAR(max),
    [Karosserieform] NVARCHAR(max),
    [AnzahlTueren] INT,
    [AnzahlSitze] INT,
    [AnzahlAchsen] INT,
    [Nettogrundpreis] FLOAT(53),
    [Motortyp] NVARCHAR(max),
    [LeistungkW] INT,
    [Leistung] INT,
    [Hubraum] INT,
    [DrehmomentMax] FLOAT(53),
    [Hoechstgeschwindigkeit] INT,
    [Beschleunigung] FLOAT(53),
    [Antriebsart] NVARCHAR(max),
    [AnzahlZylinder] INT,
    [Zylinderanordnung] NVARCHAR(max),
    [Verdichtungsverh├ñltnis] NVARCHAR(max),
    [Kolbenhub] FLOAT(53),
    [Zylinderbohrung] FLOAT(53),
    [MotorartZusatz] NVARCHAR(max),
    [Kraftstoffart] NVARCHAR(max),
    [Sekundaerkraftstoff] NVARCHAR(max),
    [Katalysatorart] NVARCHAR(max),
    [StartStoppFunktion] BIT,
    [Tanktinhalt] FLOAT(53),
    [VerbrauchInnerorts] FLOAT(53),
    [VerbrauchAusserorts] FLOAT(53),
    [Verbrauchkombiniert] FLOAT(53),
    [CO2_Emission_g_km] INT,
    [Effizienzklasse] NVARCHAR(max),
    [Emissionsklasse] NVARCHAR(max),
    [Partikelfilter] NVARCHAR(max),
    [NOx] FLOAT(53),
    [Oelart] NVARCHAR(max),
    [CO2_Emission_g_km_10erBereich] NVARCHAR(max),
    [CO2_Emission_g_km_20erBereich] NVARCHAR(max),
    [Verbrauch_Liter_auf_100] FLOAT(53),
    [Verbrauch25erbereich] NVARCHAR(max),
    [Verbrauch5erbereich] NVARCHAR(max),
    [ZulaessigeAnhaengerlastGebremst] INT,
    [ZulaessigeAnhaengerlastUngebremst] INT,
    [GewichtinKG] INT,
    [GewichtinKG100erBereich] NVARCHAR(max),
    [GewichtinKG250erBereich] NVARCHAR(max),
    [GewichtinKG500erBereich] NVARCHAR(max),
    [MaxGewichtinKG] INT,
    [MaxGewichtinKG100erBereich] NVARCHAR(max),
    [MaxGewichtinKG250erBereich] NVARCHAR(max),
    [MaxGewichtinKG500erBereich] NVARCHAR(max),
    [MaxZuladungInKG] INT,
    [MaxZuladung100erBereich] NVARCHAR(max),
    [MaxZuladung250erBereich] NVARCHAR(max),
    [MaxZuladung500erBereich] NVARCHAR(max),
    [Laenge] FLOAT(53),
    [Breite] FLOAT(53),
    [Hoehe] FLOAT(53),
    [Radstand] FLOAT(53),
    [Spurweite] FLOAT(53),
    [Bodenfreiheit] FLOAT(53),
    [Wendekreis] FLOAT(53),
    [AnzahlGaenge] NVARCHAR(max),
    [Getriebeart] NVARCHAR(max),
    [Hybridart] NVARCHAR(max),
    [Elektoantrieb] NVARCHAR(max),
    [Batterietyp] NVARCHAR(max),
    [ReichweiteBatterie] INT,
    [AufladeZeitBatterie] FLOAT(53),
    [SchnellladezeitBatterie] FLOAT(53),
    [LebenserwartungBatterie] INT,
    [BetriebstemperaturBatterie] FLOAT(53),
    [Batteriespannung] FLOAT(53),
    [Batteriestrom] FLOAT(53),
    [Reifendimension_Vorne] NVARCHAR(max),
    [Reifendimension_Hinten] NVARCHAR(max),
    [Felgendimension_Vorne] NVARCHAR(max),
    [Felgendimension_Hinten] NVARCHAR(max),
    [Lagerort] NVARCHAR(max),
    [AktuelleBereifung] NVARCHAR(max),
    [ProfiltiefeWrVr] DECIMAL(18,2),
    [ProfiltiefeWrVl] DECIMAL(18,2),
    [ProfiltiefeWrHr] DECIMAL(18,2),
    [ProfiltiefeWrHl] DECIMAL(18,2),
    [ProfiltiefeSrVr] DECIMAL(18,2),
    [ProfiltiefeSrVl] DECIMAL(18,2),
    [ProfiltiefeSrHr] DECIMAL(18,2),
    [ProfiltiefeSrHl] DECIMAL(18,2),
    [ReifengroesseSommer] NVARCHAR(max),
    [ReifengroesseWinter] NVARCHAR(max),
    [NaechsteHauptAbgasUntersuchung] DATETIME2,
    [IstAktiv] BIT,
    [IstAktivGueltigAb] DATETIME2,
    [IstAktivGueltigBis] DATETIME2,
    [FahrzeugtypId] INT,
    [LetzteUnfallverh├╝tungsvorschriftKontrolle] DATETIME2,
    [NaechsteUnfallverh├╝tungsvorschriftKontrolle] DATETIME2,
    [ReifenDienstleisterDienstleisterId] INT,
    [GruppenversicherungId] INT,
    [GruppenversicherungsvertragId] INT,
    [ExternalDataField] VARCHAR(max),
    [LandZulassung] NVARCHAR(max) NOT NULL CONSTRAINT [DF__Fahrzeuge__LandZ__116A8EFB] DEFAULT 'N''',
    [PoolId] INT,
    [ServiceIntervallJahre] INT,
    [ServiceLetzter] DATETIME2,
    [ServiceNaechster] DATETIME2,
    [PeriodEnd] DATETIME2 NOT NULL CONSTRAINT [DF__Fahrzeuge__Perio__25DB9BFC] DEFAULT 9999-12-31T23:59:59.9999999,
    [PeriodStart] DATETIME2 NOT NULL CONSTRAINT [DF__Fahrzeuge__Perio__26CFC035] DEFAULT 0001-01-01T00:00:00.0000000,
    CONSTRAINT [PK_Fahrzeuge] PRIMARY KEY CLUSTERED ([TenantItemId])
);

-- CreateTable
CREATE TABLE [dbo].[FahrzeugeHistory] (
    [TenantItemId] INT NOT NULL,
    [Kennzeichen] NVARCHAR(max) NOT NULL,
    [KennzeichenGueltigAb] DATETIME2,
    [Fin] NVARCHAR(max),
    [Name] NVARCHAR(max),
    [Erstzulassung] DATETIME2,
    [Laufleistung] INT,
    [Fahrzeugstatus] NVARCHAR(max) NOT NULL,
    [FahrzeugstatusGueltigAb] DATETIME2,
    [LetzteZulassung] DATETIME2,
    [Kostenstelle1] NVARCHAR(max),
    [Kostenstelle2] NVARCHAR(max),
    [Kostenstelle1GueltigAb] DATETIME2,
    [Kostenstelle2GueltigAb] DATETIME2,
    [Beschreibung1] NVARCHAR(max),
    [Beschreibung2] NVARCHAR(max),
    [Autofarbe] NVARCHAR(max),
    [Polsterfarbe] NVARCHAR(max),
    [InNuceFahrzeugNummer] INT,
    [InNuceKndNr] NVARCHAR(max),
    [LieferantDienstleisterId] INT,
    [KaufvertragId] INT,
    [MietvertragId] INT,
    [LeasingvertragId] INT,
    [KundeTenantItemId] INT NOT NULL,
    [Nettolistenpreis] FLOAT(53),
    [NettoSonderausstattungPreis] FLOAT(53),
    [NachtraeglichesZubehoerPreis] FLOAT(53),
    [Bruttolistenpreis] FLOAT(53),
    [Bruttolistenpreis_fuer_den_GwV] FLOAT(53),
    [Gesamtpreis] FLOAT(53),
    [KfzSteuer] FLOAT(53),
    [KfzSteuernummer] NVARCHAR(max),
    [ExternalId] NVARCHAR(max),
    [KennzeichenAnh├ñnger] NVARCHAR(max),
    [Anmerkungen] NVARCHAR(max),
    [Dienstleisternummer] NVARCHAR(max),
    [DienstleisterName] NVARCHAR(max),
    [Erzeuger] NVARCHAR(max),
    [Eingang] DATETIME2,
    [Bestellung] NVARCHAR(max),
    [BestellZeitinTagen] NVARCHAR(max),
    [UnverbindlicherLiefertermin] DATETIME2,
    [Lieferung] DATETIME2,
    [LieferzeitInTagen] NVARCHAR(max),
    [Rueckgabe] DATETIME2,
    [LetzterKilometerstand_Anzahl] INT,
    [LetzterKilometerstand_Tag] DATETIME2,
    [ErsterKilometerstand_Anzahl] INT,
    [ErsterKilometerstand_Tag] DATETIME2,
    [GefahreneKilometer] INT,
    [Anlagennummer] INT,
    [AFA] INT,
    [Buchwert] INT,
    [Leistung10erBereich] NVARCHAR(max),
    [Leistung20erBereich] NVARCHAR(max),
    [Hersteller] NVARCHAR(max),
    [Modell] NVARCHAR(max),
    [Typ] NVARCHAR(max),
    [TypschluesselDatenlieferant] NVARCHAR(max),
    [TypschluesselInNuce] NVARCHAR(max),
    [Fahrzeugart] NVARCHAR(max),
    [PoolFahrzeug] BIT,
    [Produktionsbeginn] DATETIME2,
    [Produktionsende] DATETIME2,
    [HerstellerBestellCode] NVARCHAR(max),
    [Tsn] NVARCHAR(max),
    [Hsn] NVARCHAR(max),
    [Karosserieform] NVARCHAR(max),
    [AnzahlTueren] INT,
    [AnzahlSitze] INT,
    [AnzahlAchsen] INT,
    [Nettogrundpreis] FLOAT(53),
    [Motortyp] NVARCHAR(max),
    [LeistungkW] INT,
    [Leistung] INT,
    [Hubraum] INT,
    [DrehmomentMax] FLOAT(53),
    [Hoechstgeschwindigkeit] INT,
    [Beschleunigung] FLOAT(53),
    [Antriebsart] NVARCHAR(max),
    [AnzahlZylinder] INT,
    [Zylinderanordnung] NVARCHAR(max),
    [Verdichtungsverh├ñltnis] NVARCHAR(max),
    [Kolbenhub] FLOAT(53),
    [Zylinderbohrung] FLOAT(53),
    [MotorartZusatz] NVARCHAR(max),
    [Kraftstoffart] NVARCHAR(max),
    [Sekundaerkraftstoff] NVARCHAR(max),
    [Katalysatorart] NVARCHAR(max),
    [StartStoppFunktion] BIT,
    [Tanktinhalt] FLOAT(53),
    [VerbrauchInnerorts] FLOAT(53),
    [VerbrauchAusserorts] FLOAT(53),
    [Verbrauchkombiniert] FLOAT(53),
    [CO2_Emission_g_km] INT,
    [Effizienzklasse] NVARCHAR(max),
    [Emissionsklasse] NVARCHAR(max),
    [Partikelfilter] NVARCHAR(max),
    [NOx] FLOAT(53),
    [Oelart] NVARCHAR(max),
    [CO2_Emission_g_km_10erBereich] NVARCHAR(max),
    [CO2_Emission_g_km_20erBereich] NVARCHAR(max),
    [Verbrauch_Liter_auf_100] FLOAT(53),
    [Verbrauch25erbereich] NVARCHAR(max),
    [Verbrauch5erbereich] NVARCHAR(max),
    [ZulaessigeAnhaengerlastGebremst] INT,
    [ZulaessigeAnhaengerlastUngebremst] INT,
    [GewichtinKG] INT,
    [GewichtinKG100erBereich] NVARCHAR(max),
    [GewichtinKG250erBereich] NVARCHAR(max),
    [GewichtinKG500erBereich] NVARCHAR(max),
    [MaxGewichtinKG] INT,
    [MaxGewichtinKG100erBereich] NVARCHAR(max),
    [MaxGewichtinKG250erBereich] NVARCHAR(max),
    [MaxGewichtinKG500erBereich] NVARCHAR(max),
    [MaxZuladungInKG] INT,
    [MaxZuladung100erBereich] NVARCHAR(max),
    [MaxZuladung250erBereich] NVARCHAR(max),
    [MaxZuladung500erBereich] NVARCHAR(max),
    [Laenge] FLOAT(53),
    [Breite] FLOAT(53),
    [Hoehe] FLOAT(53),
    [Radstand] FLOAT(53),
    [Spurweite] FLOAT(53),
    [Bodenfreiheit] FLOAT(53),
    [Wendekreis] FLOAT(53),
    [AnzahlGaenge] NVARCHAR(max),
    [Getriebeart] NVARCHAR(max),
    [Hybridart] NVARCHAR(max),
    [Elektoantrieb] NVARCHAR(max),
    [Batterietyp] NVARCHAR(max),
    [ReichweiteBatterie] INT,
    [AufladeZeitBatterie] FLOAT(53),
    [SchnellladezeitBatterie] FLOAT(53),
    [LebenserwartungBatterie] INT,
    [BetriebstemperaturBatterie] FLOAT(53),
    [Batteriespannung] FLOAT(53),
    [Batteriestrom] FLOAT(53),
    [Reifendimension_Vorne] NVARCHAR(max),
    [Reifendimension_Hinten] NVARCHAR(max),
    [Felgendimension_Vorne] NVARCHAR(max),
    [Felgendimension_Hinten] NVARCHAR(max),
    [Lagerort] NVARCHAR(max),
    [AktuelleBereifung] NVARCHAR(max),
    [ProfiltiefeWrVr] DECIMAL(18,2),
    [ProfiltiefeWrVl] DECIMAL(18,2),
    [ProfiltiefeWrHr] DECIMAL(18,2),
    [ProfiltiefeWrHl] DECIMAL(18,2),
    [ProfiltiefeSrVr] DECIMAL(18,2),
    [ProfiltiefeSrVl] DECIMAL(18,2),
    [ProfiltiefeSrHr] DECIMAL(18,2),
    [ProfiltiefeSrHl] DECIMAL(18,2),
    [ReifengroesseSommer] NVARCHAR(max),
    [ReifengroesseWinter] NVARCHAR(max),
    [NaechsteHauptAbgasUntersuchung] DATETIME2,
    [IstAktiv] BIT,
    [IstAktivGueltigAb] DATETIME2,
    [IstAktivGueltigBis] DATETIME2,
    [FahrzeugtypId] INT,
    [LetzteUnfallverh├╝tungsvorschriftKontrolle] DATETIME2,
    [NaechsteUnfallverh├╝tungsvorschriftKontrolle] DATETIME2,
    [ReifenDienstleisterDienstleisterId] INT,
    [GruppenversicherungId] INT,
    [GruppenversicherungsvertragId] INT,
    [ExternalDataField] VARCHAR(max),
    [LandZulassung] NVARCHAR(max) NOT NULL,
    [PoolId] INT,
    [ServiceIntervallJahre] INT,
    [ServiceLetzter] DATETIME2,
    [ServiceNaechster] DATETIME2,
    [PeriodEnd] DATETIME2 NOT NULL,
    [PeriodStart] DATETIME2 NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[FahrzeugKategorien] (
    [FahrzeugKategorieId] INT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(max),
    CONSTRAINT [PK_FahrzeugKategorien] PRIMARY KEY CLUSTERED ([FahrzeugKategorieId])
);

-- CreateTable
CREATE TABLE [dbo].[Fahrzeugtyp] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Hersteller] NVARCHAR(max),
    [Modell] NVARCHAR(max),
    [Typbezeichnung] NVARCHAR(max),
    [Typschl├╝ssel] NVARCHAR(max),
    [Fahrzeugart] NVARCHAR(max),
    [Produktionsbeginn] NVARCHAR(max),
    [Produktionsende] NVARCHAR(max),
    [HSN] NVARCHAR(max),
    [TSN] NVARCHAR(max),
    [Sitze] SMALLINT NOT NULL,
    [Tueren] SMALLINT NOT NULL,
    [Achsen] SMALLINT NOT NULL,
    [Nettopreis] FLOAT(53) NOT NULL,
    [Leistung] SMALLINT NOT NULL,
    [Hubraum] INT NOT NULL,
    CONSTRAINT [PK_Fahrzeugtyp] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Gruppenmitglieder] (
    [GruppenmitgliedId] INT NOT NULL IDENTITY(1,1),
    [SystemName] NVARCHAR(max),
    [ArbeitsgruppeId] INT NOT NULL CONSTRAINT [DF__Gruppenmi__Arbei__689D8392] DEFAULT 0,
    [MfilesName] NVARCHAR(max),
    CONSTRAINT [PK_Gruppenmitglieder] PRIMARY KEY CLUSTERED ([GruppenmitgliedId])
);

-- CreateTable
CREATE TABLE [dbo].[Gruppenversicherung] (
    [GruppenversicherungId] INT NOT NULL IDENTITY(1,1),
    [Gruppenvertragsnummer] NVARCHAR(max),
    [Versicherungsbeginn] DATETIME2,
    [Versicherungsende] DATETIME2,
    [Kommentar] NVARCHAR(max),
    [VsVK] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenver__VsVK__4EDDB18F] DEFAULT 0.0000000000000000,
    [VsKH] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenver__VsKH__4FD1D5C8] DEFAULT 0.0000000000000000,
    [VsTK] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenver__VsTK__50C5FA01] DEFAULT 0.0000000000000000,
    [VsIU] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenver__VsIU__51BA1E3A] DEFAULT 0.0000000000000000,
    [VsSchutz] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__VsSch__52AE4273] DEFAULT 0.0000000000000000,
    [SbVK] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenver__SbVK__53A266AC] DEFAULT 0.0000000000000000,
    [SbTK] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenver__SbTK__54968AE5] DEFAULT 0.0000000000000000,
    [SbIU] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenver__SbIU__558AAF1E] DEFAULT 0.0000000000000000,
    [SbSchutz] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__SbSch__567ED357] DEFAULT 0.0000000000000000,
    [SbKH] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenver__SbKH__5772F790] DEFAULT 0.0000000000000000,
    [BedKH] NVARCHAR(max),
    [BedVK] NVARCHAR(max),
    [BedTK] NVARCHAR(max),
    [BedIU] NVARCHAR(max),
    [BedSchutz] NVARCHAR(max),
    [BeitragVK] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__Beitr__58671BC9] DEFAULT 0.0000000000000000,
    [BeitragTK] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__Beitr__595B4002] DEFAULT 0.0000000000000000,
    [BeitragIU] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__Beitr__5A4F643B] DEFAULT 0.0000000000000000,
    [BeitragSchutz] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__Beitr__5B438874] DEFAULT 0.0000000000000000,
    [BeitragKH] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__Beitr__5C37ACAD] DEFAULT 0.0000000000000000,
    [Jahresbeitrag] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__Jahre__5D2BD0E6] DEFAULT 0.0000000000000000,
    [Zahlweise] NVARCHAR(max),
    [VersicherungsdienstleisterDienstleisterId] INT NOT NULL CONSTRAINT [DF__Gruppenve__Versi__5E1FF51F] DEFAULT 0,
    [KundeTenantItemId] INT NOT NULL CONSTRAINT [DF__Gruppenve__Kunde__5F141958] DEFAULT 0,
    [StandardBeitragIU] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__Stand__60083D91] DEFAULT 0.0000000000000000,
    [StandardBeitragKH] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__Stand__60FC61CA] DEFAULT 0.0000000000000000,
    [StandardBeitragSchutz] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__Stand__61F08603] DEFAULT 0.0000000000000000,
    [StandardBeitragTK] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__Stand__62E4AA3C] DEFAULT 0.0000000000000000,
    [StandardBeitragVK] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__Stand__63D8CE75] DEFAULT 0.0000000000000000,
    [ExternalDataField] VARCHAR(max),
    CONSTRAINT [PK_Gruppenversicherung] PRIMARY KEY CLUSTERED ([GruppenversicherungId])
);

-- CreateTable
CREATE TABLE [dbo].[Gruppenversicherungsvertrag] (
    [GruppenversicherungsvertragId] INT NOT NULL IDENTITY(1,1),
    [Vertragsnummer] NVARCHAR(max),
    [BeitragVK] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__Beitr__473C8FC7] DEFAULT 0.0000000000000000,
    [BeitragTK] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__Beitr__4830B400] DEFAULT 0.0000000000000000,
    [BeitragIU] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__Beitr__4924D839] DEFAULT 0.0000000000000000,
    [BeitragSchutz] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__Beitr__4A18FC72] DEFAULT 0.0000000000000000,
    [BeitragKH] FLOAT(53) NOT NULL CONSTRAINT [DF__Gruppenve__Beitr__4B0D20AB] DEFAULT 0.0000000000000000,
    [GruppenversicherungId] INT,
    [Kennzeichen] NVARCHAR(max),
    CONSTRAINT [PK_Gruppenversicherungsvertrag] PRIMARY KEY CLUSTERED ([GruppenversicherungsvertragId])
);

-- CreateTable
CREATE TABLE [dbo].[IdMappings] (
    [IdMappingsId] INT NOT NULL IDENTITY(1,1),
    [DienstleisterId] INT NOT NULL,
    [KategorieId] INT NOT NULL,
    [KategorieTyp] NVARCHAR(max),
    CONSTRAINT [PK_IdMappings] PRIMARY KEY CLUSTERED ([IdMappingsId])
);

-- CreateTable
CREATE TABLE [dbo].[ImplCategories] (
    [ImplCategoryId] INT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(max),
    [KundeTenantItemId] INT,
    CONSTRAINT [PK_ImplCategories] PRIMARY KEY CLUSTERED ([ImplCategoryId])
);

-- CreateTable
CREATE TABLE [dbo].[ImplProperties] (
    [ImplPropertyId] INT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(max),
    [ImplSubCategoryId] INT NOT NULL CONSTRAINT [DF__ImplPrope__ImplS__3DB3258D] DEFAULT 0,
    [Value] NVARCHAR(max),
    [KundeTenantItemId] INT,
    CONSTRAINT [PK_ImplProperties] PRIMARY KEY CLUSTERED ([ImplPropertyId])
);

-- CreateTable
CREATE TABLE [dbo].[ImplSubCategories] (
    [ImplSubCategoryId] INT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(max),
    [ImplCategoryId] INT NOT NULL CONSTRAINT [DF__ImplSubCa__ImplC__38EE7070] DEFAULT 0,
    [KundeTenantItemId] INT,
    CONSTRAINT [PK_ImplSubCategories] PRIMARY KEY CLUSTERED ([ImplSubCategoryId])
);

-- CreateTable
CREATE TABLE [dbo].[ImportPropertyMaps] (
    [ImportPropertyMapId] INT NOT NULL IDENTITY(1,1),
    [ImportProperties] NVARCHAR(max),
    [DataSourceColumn] NVARCHAR(max),
    [ImportTemplateTemplateId] INT NOT NULL CONSTRAINT [DF__ImportPro__Impor__351DDF8C] DEFAULT 0,
    [Parent] NVARCHAR(max),
    CONSTRAINT [PK_ImportPropertyMaps] PRIMARY KEY CLUSTERED ([ImportPropertyMapId])
);

-- CreateTable
CREATE TABLE [dbo].[ImportTemplates] (
    [TemplateId] INT NOT NULL IDENTITY(1,1),
    [TemplateName] NVARCHAR(max),
    [ScopedEntities] NVARCHAR(max),
    CONSTRAINT [PK_ImportTemplates] PRIMARY KEY CLUSTERED ([TemplateId])
);

-- CreateTable
CREATE TABLE [dbo].[Kaufvertrags] (
    [KaufvertragId] INT NOT NULL IDENTITY(1,1),
    [inNuceKaufvertragId] INT NOT NULL,
    [Bezeichnung] NVARCHAR(max),
    [Beginn] DATETIME2,
    [Ende] DATETIME2,
    [Beschreibung] NVARCHAR(max),
    [Vertragsnummer] NVARCHAR(max),
    [Kostenstelle] NVARCHAR(max),
    [VertragspartnerDienstleisterId] INT,
    [KundeTenantItemId] INT,
    [ExternalDataField] VARCHAR(max),
    [IstAktivGueltigBis] DATETIME2,
    CONSTRAINT [PK_Kaufvertrags] PRIMARY KEY CLUSTERED ([KaufvertragId])
);

-- CreateTable
CREATE TABLE [dbo].[KontaktBeziehungen] (
    [KontaktBeziehungId] INT NOT NULL IDENTITY(1,1),
    [BeziehungTyp] NVARCHAR(max) NOT NULL,
    [Bezeichnung] NVARCHAR(max),
    [KundeTenantItemId] INT,
    [ParentKontaktBeziehungId] INT,
    [FillColor] NVARCHAR(max),
    CONSTRAINT [PK_KontaktBeziehungen] PRIMARY KEY CLUSTERED ([KontaktBeziehungId])
);

-- CreateTable
CREATE TABLE [dbo].[Konzern] (
    [KonzernId] INT NOT NULL IDENTITY(1,1),
    [KonzernName] NVARCHAR(max),
    [ExternalDataField] VARCHAR(max),
    CONSTRAINT [PK_Konzern] PRIMARY KEY CLUSTERED ([KonzernId])
);

-- CreateTable
CREATE TABLE [dbo].[Kostenvoranschlag] (
    [KostenvoranschlagId] INT NOT NULL IDENTITY(1,1),
    [Schadennummer] NVARCHAR(max),
    [Kennzeichen] NVARCHAR(max),
    [UniqueKvId] NVARCHAR(max),
    [KvStatus] NVARCHAR(max) NOT NULL,
    [Bemerkung] NVARCHAR(max),
    [Eingangsdatum] DATETIME2,
    [SchadenId] INT,
    [Gesamtkosten] DECIMAL(18,2) NOT NULL CONSTRAINT [DF__Kostenvor__Gesam__76D69450] DEFAULT 0.0,
    [Erstzulassung] NVARCHAR(max),
    [Halter] NVARCHAR(max),
    [HalterAnschrift] NVARCHAR(max),
    [Hersteller] NVARCHAR(max),
    [VIN] NVARCHAR(max),
    [Werkstatt] NVARCHAR(max),
    [Korrekturbetrag] DECIMAL(18,2) NOT NULL CONSTRAINT [DF__Kostenvor__Korre__25DB9BFC] DEFAULT 0.0,
    [Schadenart] NVARCHAR(max) NOT NULL,
    CONSTRAINT [PK_Kostenvoranschlag] PRIMARY KEY CLUSTERED ([KostenvoranschlagId])
);

-- CreateTable
CREATE TABLE [dbo].[Kunden] (
    [TenantItemId] INT NOT NULL IDENTITY(1,1),
    [Anrede] INT,
    [Vorname] NVARCHAR(max),
    [Nachname] NVARCHAR(max),
    [Firmenbezeichnung] NVARCHAR(max),
    [NameNiederlassung] NVARCHAR(max),
    [Vertragsnummer] NVARCHAR(max),
    [OnlineZugang] BIT NOT NULL,
    [Domain] NVARCHAR(max),
    [BetreuendeEinheit] NVARCHAR(max),
    [InNuceKndNr] NVARCHAR(max),
    [InNuceMatchCode] NVARCHAR(max),
    [IstAktiv] BIT,
    [IstAktivGueltigAb] DATETIME2,
    [IstAktivGueltigBis] DATETIME2,
    [KonzernId] INT,
    [IstFuhrparkmanagement] BIT NOT NULL,
    [ExternalDataField] VARCHAR(max),
    [Dokumentueberwachung] BIT NOT NULL,
    [Kundenbetreuer] NVARCHAR(max),
    [AkquiseStatus] NVARCHAR(max),
    [KontaktTyp] NVARCHAR(max),
    [DriverCheckId] NVARCHAR(max),
    [Kundencode] NVARCHAR(255),
    CONSTRAINT [PK_Kunden] PRIMARY KEY CLUSTERED ([TenantItemId])
);

-- CreateTable
CREATE TABLE [dbo].[Lackierarbeit] (
    [LackierarbeitId] INT NOT NULL IDENTITY(1,1),
    [LS] NVARCHAR(max),
    [DVN] NVARCHAR(max),
    [APN] NVARCHAR(max),
    [Stufe] NVARCHAR(max),
    [ZeiteinheitenAusKv] DECIMAL(18,2) NOT NULL,
    [PreisProEinheitAusKv] DECIMAL(18,2) NOT NULL,
    [GesamtpreisAusKv] DECIMAL(18,2) NOT NULL,
    [ZeiteinheitenFinal] DECIMAL(18,2) NOT NULL,
    [PreisProEinheitFinal] DECIMAL(18,2) NOT NULL,
    [GesamtpreisFinal] DECIMAL(18,2) NOT NULL,
    [Bezeichnung] NVARCHAR(max),
    [UniqueKvId] NVARCHAR(max),
    [PositionStatus] INT NOT NULL,
    [Bemerkung] NVARCHAR(max),
    [KostenvoranschlagId] INT NOT NULL,
    CONSTRAINT [PK_Lackierarbeit] PRIMARY KEY CLUSTERED ([LackierarbeitId])
);

-- CreateTable
CREATE TABLE [dbo].[Lackmaterial] (
    [LackmaterialId] INT NOT NULL IDENTITY(1,1),
    [Bezeichnung] NVARCHAR(max),
    [PositionStatus] INT NOT NULL,
    [GesamtpreisAusKv] DECIMAL(18,2) NOT NULL,
    [GesamtpreisFinal] DECIMAL(18,2) NOT NULL,
    [KostenvoranschlagId] INT NOT NULL,
    [UniqueKvId] NVARCHAR(max),
    [AnzahlAusKv] INT NOT NULL CONSTRAINT [DF__Lackmater__Anzah__5B638405] DEFAULT 0,
    [AnzahlFinal] INT NOT NULL CONSTRAINT [DF__Lackmater__Anzah__5C57A83E] DEFAULT 0,
    [EinzelpreisAusKv] DECIMAL(18,2) NOT NULL CONSTRAINT [DF__Lackmater__Einze__5D4BCC77] DEFAULT 0.0,
    [EinzelpreisFinal] DECIMAL(18,2) NOT NULL CONSTRAINT [DF__Lackmater__Einze__5E3FF0B0] DEFAULT 0.0,
    [Bemerkung] NVARCHAR(max),
    [DVN] NVARCHAR(max),
    [Lackart] NVARCHAR(max),
    [Lackiermethode] NVARCHAR(max),
    CONSTRAINT [PK_Lackmaterial] PRIMARY KEY CLUSTERED ([LackmaterialId])
);

-- CreateTable
CREATE TABLE [dbo].[LackProviders] (
    [LackProviderId] INT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(450),
    CONSTRAINT [PK_LackProviders] PRIMARY KEY CLUSTERED ([LackProviderId])
);

-- CreateTable
CREATE TABLE [dbo].[Leasingrechnung] (
    [LeasingRechnungId] INT NOT NULL IDENTITY(1,1),
    [Konto] NVARCHAR(max),
    [KdNr] NVARCHAR(max),
    [Kundenname] NVARCHAR(max),
    [Rechnungsdatum] DATETIME2,
    [Rechnungsposition] INT NOT NULL,
    [Waehrung] NVARCHAR(max),
    [BetragNetto] DECIMAL(18,2) NOT NULL,
    [Ust] NVARCHAR(max),
    [BetragUst] DECIMAL(18,2) NOT NULL,
    [AbrechnungszeitraumBeginn] DATETIME2,
    [AbrechnungszeitraumEnde] DATETIME2,
    [Leistungsart] NVARCHAR(max),
    [Vertragsnummer] NVARCHAR(max),
    [Kennzeichen] NVARCHAR(max),
    [Versicherungsbeginn] DATETIME2,
    [Versicherungsende] DATETIME2,
    [Kostenstelle] NVARCHAR(max),
    [Zusatztext] NVARCHAR(max),
    [FahrzeugTenantItemId] INT,
    CONSTRAINT [PK_Leasingrechnung] PRIMARY KEY CLUSTERED ([LeasingRechnungId])
);

-- CreateTable
CREATE TABLE [dbo].[Leasingvertrag] (
    [LeasingvertragId] INT NOT NULL IDENTITY(1,1),
    [InNuceLeasingvertragId] NVARCHAR(max),
    [TenantItemId] INT NOT NULL,
    [LeasingStatus] BIT,
    [Bezeichnung] NVARCHAR(max),
    [Beginn] DATETIME2,
    [Ende] DATETIME2,
    [Beschreibung] NVARCHAR(max),
    [Jahreslaufleistung] INT NOT NULL,
    [Laufzeit] INT NOT NULL,
    [LeasingLaufzeitGesamt] INT NOT NULL,
    [Leasingart] NVARCHAR(max),
    [NettoGesamtMonatsrate] FLOAT(53) NOT NULL,
    [NettoFinanzleasingMonatsrate] FLOAT(53) NOT NULL,
    [Leasingfaktor] FLOAT(53) NOT NULL,
    [Gehaltsverzicht] BIT NOT NULL,
    [FinanzleasingMehrkilometerFreigrenze] INT NOT NULL,
    [FinanzleasingMinderkilometerFreigrenze] INT NOT NULL,
    [FinanzleasingMehrkilometerFaktor] FLOAT(53) NOT NULL,
    [FinanzleasingMinderkilometerFaktor] FLOAT(53) NOT NULL,
    [FinanzleasingMinderkilometerMaximal] INT,
    [FinanzleasingMinderkilometerMaximalRueckerstattung] INT,
    [WartungsUndVerschlei├ƒpauschaleBetrag] FLOAT(53) NOT NULL,
    [WartungsUndVerschlei├ƒMehrkilometerFreigrenze] INT NOT NULL,
    [WartungsUndVerschlei├ƒMinderkilometerFreigrenze] INT NOT NULL,
    [WartungsUndVerschlei├ƒMehrkilometerFaktor] FLOAT(53) NOT NULL,
    [WartungsUndVerschlei├ƒMinderkilometerFaktor] FLOAT(53) NOT NULL,
    [Abrechnungsart] NVARCHAR(max),
    [Sommerreifen] FLOAT(53) NOT NULL,
    [Winterreifen] FLOAT(53) NOT NULL,
    [Ganzjahresreifen] NVARCHAR(max),
    [Reifenwechsel] FLOAT(53) NOT NULL,
    [Reifensatzkontingent] NVARCHAR(max),
    [Felgenart] NVARCHAR(max),
    [SaisonaleBereifung] BIT,
    [Einlagerung] NVARCHAR(max),
    [VersicherungsbetragGesamt] FLOAT(53) NOT NULL,
    [Versicherungshandling] FLOAT(53) NOT NULL,
    [HaftpflichtBetrag] FLOAT(53) NOT NULL,
    [VollkaskoBetrag] FLOAT(53) NOT NULL,
    [SelbstbeteiligungVollkaskoBetrag] FLOAT(53) NOT NULL,
    [TeilkaskoBetrag] FLOAT(53) NOT NULL,
    [SelbstBeteiligungTeilkaskoBetrag] FLOAT(53) NOT NULL,
    [Fahrereinmalzahlung] FLOAT(53) NOT NULL,
    [Verwaltungspauschale] FLOAT(53) NOT NULL,
    [GEZ] FLOAT(53) NOT NULL,
    [Steuern] FLOAT(53) NOT NULL,
    [ServiceUndTankkarte] FLOAT(53) NOT NULL,
    [Kraftstoffpauschale] FLOAT(53) NOT NULL,
    [KaskoSchutz] FLOAT(53) NOT NULL,
    [MietwagenKosten] FLOAT(53) NOT NULL,
    [KmBeiVertragsendeLeasing] INT NOT NULL,
    [MehrkilometerBeiVertragsende] INT NOT NULL,
    [StillschweigendeVerlaengerung] BIT,
    [VerlaengerungLeasingvertragBis] DATETIME2,
    [Laufleistung] INT,
    [LaufleistungStand] DATETIME2,
    [LaufleistungAktuell] INT,
    [LaufleistungRest] INT,
    [IstAktiv] BIT,
    [IstAktivGueltigAb] DATETIME2,
    [IstAktivGueltigBis] DATETIME2,
    [Kostenstelle1] NVARCHAR(max),
    [Kostenstelle2] NVARCHAR(max),
    [Mietkauf] BIT,
    [InNuceKeyDienstleisterDienstleisterId] INT,
    [AusliefenderHaendlerDienstleisterId] INT,
    [KundeTenantItemId] INT,
    [LeasingvertragVertragsnummer] NVARCHAR(max),
    [ExternalDataField] VARCHAR(max),
    CONSTRAINT [PK_Leasingvertrag] PRIMARY KEY CLUSTERED ([LeasingvertragId])
);

-- CreateTable
CREATE TABLE [dbo].[Lieferschein] (
    [LieferscheinId] INT NOT NULL IDENTITY(1,1),
    [Pos] INT,
    [Teilenummer] NVARCHAR(50),
    [Bezeichnung] NVARCHAR(max),
    [Menge] INT,
    [Upe] VARCHAR(50),
    [Rabatt] DECIMAL(18,0),
    [EPreis] DECIMAL(18,0),
    [Betrag] DECIMAL(18,0),
    [MfilesType] INT,
    [MfilesId] INT,
    CONSTRAINT [PK_Lieferschein] PRIMARY KEY CLUSTERED ([LieferscheinId])
);

-- CreateTable
CREATE TABLE [dbo].[Lieferscheine] (
    [LieferscheinId] INT NOT NULL IDENTITY(1,1),
    [LieferscheinNummer] NVARCHAR(max),
    [Schadennummer] NVARCHAR(max),
    [SchadennummerRueckstand] NVARCHAR(max),
    [Auftragsnummer] NVARCHAR(max),
    [Lieferant] NVARCHAR(max),
    [KundeName] NVARCHAR(max),
    [KundeAnschrift] NVARCHAR(max),
    [KundeNr] NVARCHAR(max),
    [RechnungNr] NVARCHAR(max),
    [RechnungsDatum] NVARCHAR(max),
    [AuftragsNr] NVARCHAR(max),
    [AuftragsNrRueckstand] NVARCHAR(max),
    [AuftragsDatum] NVARCHAR(max),
    [Ansprechpartner] NVARCHAR(max),
    [Vin] NVARCHAR(max),
    [VinRueckstand] NVARCHAR(max),
    [Kennzeichen] NVARCHAR(max),
    [KennzeichenRueckstand] NVARCHAR(max),
    [LieferscheinDatum] NVARCHAR(max),
    [Leistungsdatum] NVARCHAR(max),
    [AuftragsArt] NVARCHAR(max),
    [AnnahmeDatum] NVARCHAR(max),
    [LieferArt] NVARCHAR(max),
    [FahrzeugHersteller] NVARCHAR(max),
    [LieferscheinUniqueId] NVARCHAR(max),
    [UebergebenAnParts] BIT NOT NULL,
    [UebergabePartsDatumUhrzeit] DATETIME2 NOT NULL,
    [MfilesId] INT,
    [MfilesType] INT,
    CONSTRAINT [PK_Lieferscheine] PRIMARY KEY CLUSTERED ([LieferscheinId])
);

-- CreateTable
CREATE TABLE [dbo].[LieferscheinPositionen] (
    [LieferscheinPositionId] INT NOT NULL IDENTITY(1,1),
    [Pos] INT,
    [Teilenummer] NVARCHAR(max),
    [Bezeichnung] NVARCHAR(max),
    [Menge] INT,
    [Upe] NVARCHAR(max),
    [Rabatt] FLOAT(53),
    [EPreis] FLOAT(53),
    [Betrag] FLOAT(53),
    [LieferscheinId] INT NOT NULL,
    CONSTRAINT [PK_LieferscheinPositionen] PRIMARY KEY CLUSTERED ([LieferscheinPositionId])
);

-- CreateTable
CREATE TABLE [dbo].[Logbuch] (
    [LogbuchId] INT NOT NULL IDENTITY(1,1),
    [LogTime] DATETIME2,
    [LogUser] NVARCHAR(max),
    [LogText] NVARCHAR(max),
    [LogTopic] NVARCHAR(max),
    [IsPrivate] BIT NOT NULL,
    [SchadenNummer] NVARCHAR(max),
    [System] NVARCHAR(max),
    [Aktivitaet] NVARCHAR(max),
    [Termin] DATETIME2,
    [Aufgabe] NVARCHAR(max),
    [SchadenId] INT,
    [KundeId] INT,
    [FahrzeugId] INT,
    [FahrerId] INT,
    [FavoritId] NVARCHAR(max),
    CONSTRAINT [PK_Logbuch] PRIMARY KEY CLUSTERED ([LogbuchId])
);

-- CreateTable
CREATE TABLE [dbo].[Mietvertrag] (
    [MietvertragId] INT NOT NULL IDENTITY(1,1),
    [TenantItemId] INT NOT NULL,
    [inNuceMietvertragId] INT NOT NULL,
    [VertragspartnerDienstleisterId] INT,
    [MietwagenVertragsnummer] NVARCHAR(max),
    [Bezeichnung] NVARCHAR(max),
    [Beginn] DATETIME2,
    [Ende] DATETIME2,
    [Beschreibung] NVARCHAR(max),
    [Jahreslaufleistung] INT NOT NULL,
    [Laufzeit] INT NOT NULL,
    [Mehrtagespreis] FLOAT(53) NOT NULL,
    [MietpreisProTag] FLOAT(53) NOT NULL,
    [Gesamtmietpreis] FLOAT(53) NOT NULL,
    [Mietart] NVARCHAR(max),
    [KundeTenantItemId] INT,
    [ExternalDataField] VARCHAR(max),
    [IstAktivGueltigBis] DATETIME2,
    CONSTRAINT [PK_Mietvertrag] PRIMARY KEY CLUSTERED ([MietvertragId])
);

-- CreateTable
CREATE TABLE [dbo].[MietwagenRechnungPositionen] (
    [MietwagenRechnungPositionenId] INT NOT NULL IDENTITY(1,1),
    [Beschreibung] VARCHAR(max),
    [Einheit] VARCHAR(50),
    [Anzahl] DECIMAL(18,0),
    [Einzelpreis] DECIMAL(18,0),
    [Gesamtpreis] DECIMAL(18,0),
    CONSTRAINT [PK_MietwagenRechnungPositionen] PRIMARY KEY CLUSTERED ([MietwagenRechnungPositionenId])
);

-- CreateTable
CREATE TABLE [dbo].[Nebenkosten] (
    [NebenkostenId] INT NOT NULL IDENTITY(1,1),
    [RC] NVARCHAR(max),
    [DVN] NVARCHAR(max),
    [ETN] NVARCHAR(max),
    [AnzahlAusKv] DECIMAL(18,2) NOT NULL,
    [PreisProEinheitAusKv] DECIMAL(18,2) NOT NULL,
    [GesamtpreisAusKv] DECIMAL(18,2) NOT NULL,
    [AnzahlFinal] DECIMAL(18,2) NOT NULL,
    [PreisProEinheitFinal] DECIMAL(18,2) NOT NULL,
    [GesamtpreisFinal] DECIMAL(18,2) NOT NULL,
    [Bezeichnung] NVARCHAR(max),
    [UniqueKvId] NVARCHAR(max),
    [PositionStatus] INT NOT NULL,
    [Bemerkung] NVARCHAR(max),
    [KostenvoranschlagId] INT NOT NULL,
    CONSTRAINT [PK_Nebenkosten] PRIMARY KEY CLUSTERED ([NebenkostenId])
);

-- CreateTable
CREATE TABLE [dbo].[Regelwerk] (
    [RegelwerkId] INT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(max),
    [RegelWerkDaten] NVARCHAR(max),
    [TenantItemId] INT,
    [KundeTenantItemId] INT,
    [Arbeitsbereich] NVARCHAR(max) NOT NULL CONSTRAINT [DF__Regelwerk__Arbei__762C88DA] DEFAULT 'N''',
    [PeriodEnd] DATETIME2 NOT NULL CONSTRAINT [DF__Regelwerk__Perio__7720AD13] DEFAULT 9999-12-31T23:59:59.9999999,
    [PeriodStart] DATETIME2 NOT NULL CONSTRAINT [DF__Regelwerk__Perio__7814D14C] DEFAULT 0001-01-01T00:00:00.0000000,
    CONSTRAINT [PK_Regelwerk] PRIMARY KEY CLUSTERED ([RegelwerkId])
);

-- CreateTable
CREATE TABLE [dbo].[RegelwerkHistory] (
    [RegelwerkId] INT NOT NULL,
    [Name] NVARCHAR(max),
    [RegelWerkDaten] NVARCHAR(max),
    [TenantItemId] INT,
    [KundeTenantItemId] INT,
    [Arbeitsbereich] NVARCHAR(max) NOT NULL,
    [PeriodEnd] DATETIME2 NOT NULL,
    [PeriodStart] DATETIME2 NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[ReifenHistory] (
    [ReifenId] INT NOT NULL,
    [HerstellerDienstleister] NVARCHAR(max),
    [Reifengroesse] NVARCHAR(max),
    [Profilbezeichnung] NVARCHAR(max),
    [DOT] INT NOT NULL,
    [Bemerkung] NVARCHAR(max),
    [ProfiltiefeMesspunkt1] FLOAT(53),
    [ProfiltiefeMesspunkt2] FLOAT(53),
    [ProfiltiefeMesspunkt3] FLOAT(53),
    [MontagePosition] NVARCHAR(max),
    [Lagerort] NVARCHAR(max),
    [PeriodEnd] DATETIME2 NOT NULL,
    [PeriodStart] DATETIME2 NOT NULL,
    [ReifenKonfigurationId] INT NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[ReifenKonfiguration] (
    [ReifenKonfigurationId] INT NOT NULL IDENTITY(1,1),
    [KonfigurationName] NVARCHAR(max) NOT NULL,
    [Bemerkung] NVARCHAR(max),
    [LagerNummer] NVARCHAR(max),
    [PeriodEnd] DATETIME2 NOT NULL,
    [PeriodStart] DATETIME2 NOT NULL,
    [FahrzeugTenantItemId] INT,
    [CurrentConfig] BIT NOT NULL CONSTRAINT [DF__ReifenKon__Curre__7073AF84] DEFAULT CONVERT([bit],(0)),
    CONSTRAINT [PK__ReifenKo__938FFF582D24BDEE] PRIMARY KEY CLUSTERED ([ReifenKonfigurationId])
);

-- CreateTable
CREATE TABLE [dbo].[ReifenKonfigurationHistory] (
    [ReifenKonfigurationId] INT NOT NULL,
    [KonfigurationName] NVARCHAR(max) NOT NULL,
    [Bemerkung] NVARCHAR(max),
    [LagerNummer] NVARCHAR(max),
    [PeriodEnd] DATETIME2 NOT NULL,
    [PeriodStart] DATETIME2 NOT NULL,
    [FahrzeugTenantItemId] INT,
    [CurrentConfig] BIT NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[RentalConfirmedCreates] (
    [tradingPartnerId] NVARCHAR(4000),
    [transactionId] NVARCHAR(4000),
    [secondaryTransactionId] NVARCHAR(4000),
    [firstName] NVARCHAR(4000),
    [lastName] NVARCHAR(4000),
    [identificationNumber] NVARCHAR(4000),
    [transactionApprover] NVARCHAR(4000),
    [vehicleClass] NVARCHAR(4000),
    [vehicleDescription] NVARCHAR(4000),
    [billToPercent] NVARCHAR(4000),
    [fixedAuthorization] NVARCHAR(4000),
    [maximumEntitlement] NVARCHAR(4000),
    [CarId] INT,
    [Id] INT NOT NULL IDENTITY(1,1),
    [officeId] NVARCHAR(4000),
    [transmissionId] NVARCHAR(4000),
    [transmissionDateTime] DATETIME2,
    [transmissionType] NVARCHAR(4000),
    [transactionOwner] NVARCHAR(4000),
    [RequestState] NVARCHAR(max),
    [ResponseFullData] NVARCHAR(max),
    [UpdateNotificationRequest] NVARCHAR(max),
    [UpdateNotificationResponse] NVARCHAR(max),
    [claimNumber] NVARCHAR(20) NOT NULL,
    CONSTRAINT [PK_RentalConfirmedCreates] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Schaden] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [SchadenNummer] NVARCHAR(450) NOT NULL,
    [Schadendatum] DATETIME2,
    [Schadenmeldedatum] DATETIME2,
    [Schadenart] NVARCHAR(max) NOT NULL,
    [Schadenstatus] NVARCHAR(max) NOT NULL,
    [Schadensort] NVARCHAR(max) NOT NULL,
    [Fahrzeugstatus] NVARCHAR(max) NOT NULL,
    [SchadennummernVersicherer] NVARCHAR(max),
    [Personenschaden] BIT,
    [Vertragsnummer] NVARCHAR(max),
    [Kennzeichen] NVARCHAR(max),
    [Fin] NVARCHAR(max),
    [Erstzulassung] DATETIME2,
    [FahrzeugTyp] NVARCHAR(max),
    [FahrzeugModell] NVARCHAR(max),
    [Kundenname] NVARCHAR(max),
    [Versicherungsgesellschaft] NVARCHAR(max),
    [InNuceInsuranceNo] NVARCHAR(max),
    [InNuceSchaden] NVARCHAR(max),
    [FahrerName] NVARCHAR(max),
    [FahrerVorname] NVARCHAR(max),
    [FahrerKlassen] NVARCHAR(max),
    [FahrerSeit] DATETIME2,
    [LaufleistungInKm] INT NOT NULL,
    [Schadengruppe] NVARCHAR(max) NOT NULL,
    [Schadenursache] NVARCHAR(max),
    [Alkohol] BIT NOT NULL,
    [PrivatDienstfahrt] NVARCHAR(max),
    [Schadenschilderung] NVARCHAR(max),
    [Beschaedigung_VorneRechts] BIT,
    [Beschaedigung_TuerVorneRechts] BIT,
    [Beschaedigung_TuerHintenRechts] BIT,
    [Beschaedigung_HintenRechts] BIT,
    [Beschaedigung_Haube] BIT,
    [Beschaedigung_Frontscheibe] BIT,
    [Beschaedigung_Dach] BIT,
    [Beschaedigung_Heckscheibe] BIT,
    [Beschaedigung_Heck] BIT,
    [Beschaedigung_VorneLinks] BIT,
    [Beschaedigung_TuerVorneLinks] BIT,
    [Beschaedigung_TuerHintenLinks] BIT,
    [Beschaedigung_HintenLinks] BIT,
    [Beschaedigungen] NVARCHAR(max),
    [NichtVerkehrssicher] BIT,
    [NichtFahrbereit] BIT,
    [InNuceKndNr] NVARCHAR(max),
    [KundeTenantItemId] INT NOT NULL,
    [FahrzeugTenantItemId] INT NOT NULL,
    [Zusatzinformationen] NVARCHAR(max),
    [Abholung] BIT,
    [WunschTermin] DATETIME2,
    [WerkstattTermin] DATETIME2,
    [Abholadresse] NVARCHAR(max) NOT NULL,
    [ReparaturAustausch] NVARCHAR(max),
    [Besichtigungsort] NVARCHAR(max) NOT NULL,
    [GutachtenTyp] NVARCHAR(max) NOT NULL,
    [Gutachter] NVARCHAR(max),
    [Gutachterfestlegung] BIT NOT NULL,
    [GutachterfestlegungText] NVARCHAR(max),
    [GkkBilder] BIT NOT NULL,
    [GutachterZusatzInfo] NVARCHAR(max),
    [Reparaturkosten] DECIMAL(18,2) NOT NULL,
    [Restwert] DECIMAL(18,2) NOT NULL,
    [GutschriftVersicherung] DECIMAL(18,2) NOT NULL,
    [Eigenanteil] DECIMAL(18,2) NOT NULL,
    [SummeGutachten] DECIMAL(18,2) NOT NULL,
    [SummeKostenvoranschlag] DECIMAL(18,2) NOT NULL,
    [KostenKarosserieInstandhaltung] DECIMAL(18,2) NOT NULL,
    [Mietwagenkosten] DECIMAL(18,2) NOT NULL,
    [KostenWindschutzscheibeInstandhaltung] DECIMAL(18,2) NOT NULL,
    [Gutachterkosten] DECIMAL(18,2) NOT NULL,
    [Wertminderung] DECIMAL(18,2) NOT NULL,
    [Wiederbeschaffungswert] DECIMAL(18,2) NOT NULL,
    [NutzungsausfallInTagen] INT NOT NULL,
    [NutzungsausfallProTag] DECIMAL(18,2) NOT NULL,
    [NutzungsausfallGesamt] DECIMAL(18,2) NOT NULL,
    [Nutzungsausfallgruppe] NVARCHAR(max),
    [Anlieferungsort] NVARCHAR(max) NOT NULL,
    [Steuerungsvorgabe] NVARCHAR(max),
    [Vermieter] NVARCHAR(max),
    [Anlieferungszeitpunkt] DATETIME2,
    [MietwagenTyp] NVARCHAR(max) NOT NULL,
    [RueckgabeZeitpunkt] DATETIME2,
    [Reservierungsnummer] NVARCHAR(max),
    [Kommentar] NVARCHAR(max),
    [VersicherungId] INT,
    [DienstleisterId] INT,
    [ClaimDocumentExportId] INT,
    [IstAktiv] BIT,
    [IstAktivGueltigAb] DATETIME2,
    [IstAktivGueltigBis] DATETIME2,
    [SchadenortTypId] INT,
    [Kostenstelle1] NVARCHAR(max),
    [Kostenstelle1GueltigAb] DATETIME2,
    [Kostenstelle2] NVARCHAR(max),
    [Kostenstelle2GueltigAb] DATETIME2,
    [Rueckgabeort] VARCHAR(max),
    [GutachterBesichtigungstermin] DATETIME2,
    [SchadenstatusBegruendung] NVARCHAR(max) NOT NULL,
    [Bemerkung1] NVARCHAR(max),
    [Bemerkung2] NVARCHAR(max),
    [BilderErhalten] BIT,
    [FreigabeFuhrpark] BIT,
    [FreigabeLeasing] BIT,
    [FreigabeVU] BIT,
    [SGSBilder] BIT,
    [GutachtenErhalten] BIT,
    [RueckgabeErfolgt] BIT,
    [FreigabeMakler] BIT,
    [FreigabeNutzer] BIT,
    [FremdNummer] NVARCHAR(max),
    [SSHBilder] BIT,
    [Email] NVARCHAR(max),
    [Mobil] NVARCHAR(max),
    [Ort] NVARCHAR(max),
    [Plz] NVARCHAR(max),
    [Strasse] NVARCHAR(max),
    [Telefon] NVARCHAR(max),
    [WerkstattInfo] NVARCHAR(max),
    [PeriodEnd] DATETIME2 NOT NULL,
    [PeriodStart] DATETIME2 NOT NULL,
    CONSTRAINT [PK_Schaden] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[SchadenBeteiligter] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [AdressTyp] NVARCHAR(max) NOT NULL,
    [Anrede] NVARCHAR(max),
    [Name] NVARCHAR(max),
    [Vorname] NVARCHAR(max),
    [Land] INT NOT NULL,
    [Strasse] NVARCHAR(max),
    [Plz] NVARCHAR(max),
    [Ort] NVARCHAR(max),
    [EmailFirma] NVARCHAR(max),
    [EmailPrivat] NVARCHAR(max),
    [TelefonFirma] NVARCHAR(max),
    [MobilFirma] NVARCHAR(max),
    [MobilPrivat] NVARCHAR(max),
    [KfzKennzeichen] NVARCHAR(max),
    [Versicherung] NVARCHAR(max),
    [Versicherungsnummer] NVARCHAR(max),
    [Tagebuchnummer] NVARCHAR(max),
    [Aktenzeichen] NVARCHAR(max),
    [Verwarnung] BIT NOT NULL,
    [VerwarnungBeschreibung] NVARCHAR(max),
    [X] FLOAT(53),
    [Y] FLOAT(53),
    [SchadenId] INT NOT NULL,
    [Blutprobe] BIT NOT NULL,
    [Dienststelle] NVARCHAR(max),
    [Schadennummer] NVARCHAR(max),
    CONSTRAINT [PK_SchadenBeteiligter] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[SchadenHistory] (
    [Id] INT NOT NULL,
    [SchadenNummer] NVARCHAR(450) NOT NULL,
    [Schadendatum] DATETIME2,
    [Schadenmeldedatum] DATETIME2,
    [Schadenart] NVARCHAR(max) NOT NULL,
    [Schadenstatus] NVARCHAR(max) NOT NULL,
    [Schadensort] NVARCHAR(max) NOT NULL,
    [Fahrzeugstatus] NVARCHAR(max) NOT NULL,
    [SchadennummernVersicherer] NVARCHAR(max),
    [Personenschaden] BIT,
    [Vertragsnummer] NVARCHAR(max),
    [Kennzeichen] NVARCHAR(max),
    [Fin] NVARCHAR(max),
    [Erstzulassung] DATETIME2,
    [FahrzeugTyp] NVARCHAR(max),
    [FahrzeugModell] NVARCHAR(max),
    [Kundenname] NVARCHAR(max),
    [Versicherungsgesellschaft] NVARCHAR(max),
    [InNuceInsuranceNo] NVARCHAR(max),
    [InNuceSchaden] NVARCHAR(max),
    [FahrerName] NVARCHAR(max),
    [FahrerVorname] NVARCHAR(max),
    [FahrerKlassen] NVARCHAR(max),
    [FahrerSeit] DATETIME2,
    [LaufleistungInKm] INT NOT NULL,
    [Schadengruppe] NVARCHAR(max) NOT NULL,
    [Schadenursache] NVARCHAR(max),
    [Alkohol] BIT NOT NULL,
    [PrivatDienstfahrt] NVARCHAR(max),
    [Schadenschilderung] NVARCHAR(max),
    [Beschaedigung_VorneRechts] BIT,
    [Beschaedigung_TuerVorneRechts] BIT,
    [Beschaedigung_TuerHintenRechts] BIT,
    [Beschaedigung_HintenRechts] BIT,
    [Beschaedigung_Haube] BIT,
    [Beschaedigung_Frontscheibe] BIT,
    [Beschaedigung_Dach] BIT,
    [Beschaedigung_Heckscheibe] BIT,
    [Beschaedigung_Heck] BIT,
    [Beschaedigung_VorneLinks] BIT,
    [Beschaedigung_TuerVorneLinks] BIT,
    [Beschaedigung_TuerHintenLinks] BIT,
    [Beschaedigung_HintenLinks] BIT,
    [Beschaedigungen] NVARCHAR(max),
    [NichtVerkehrssicher] BIT,
    [NichtFahrbereit] BIT,
    [InNuceKndNr] NVARCHAR(max),
    [KundeTenantItemId] INT NOT NULL,
    [FahrzeugTenantItemId] INT NOT NULL,
    [Zusatzinformationen] NVARCHAR(max),
    [Abholung] BIT,
    [WunschTermin] DATETIME2,
    [WerkstattTermin] DATETIME2,
    [Abholadresse] NVARCHAR(max) NOT NULL,
    [ReparaturAustausch] NVARCHAR(max),
    [Besichtigungsort] NVARCHAR(max) NOT NULL,
    [GutachtenTyp] NVARCHAR(max) NOT NULL,
    [Gutachter] NVARCHAR(max),
    [Gutachterfestlegung] BIT NOT NULL,
    [GutachterfestlegungText] NVARCHAR(max),
    [GkkBilder] BIT NOT NULL,
    [GutachterZusatzInfo] NVARCHAR(max),
    [Reparaturkosten] DECIMAL(18,2) NOT NULL,
    [Restwert] DECIMAL(18,2) NOT NULL,
    [GutschriftVersicherung] DECIMAL(18,2) NOT NULL,
    [Eigenanteil] DECIMAL(18,2) NOT NULL,
    [SummeGutachten] DECIMAL(18,2) NOT NULL,
    [SummeKostenvoranschlag] DECIMAL(18,2) NOT NULL,
    [KostenKarosserieInstandhaltung] DECIMAL(18,2) NOT NULL,
    [Mietwagenkosten] DECIMAL(18,2) NOT NULL,
    [KostenWindschutzscheibeInstandhaltung] DECIMAL(18,2) NOT NULL,
    [Gutachterkosten] DECIMAL(18,2) NOT NULL,
    [Wertminderung] DECIMAL(18,2) NOT NULL,
    [Wiederbeschaffungswert] DECIMAL(18,2) NOT NULL,
    [NutzungsausfallInTagen] INT NOT NULL,
    [NutzungsausfallProTag] DECIMAL(18,2) NOT NULL,
    [NutzungsausfallGesamt] DECIMAL(18,2) NOT NULL,
    [Nutzungsausfallgruppe] NVARCHAR(max),
    [Anlieferungsort] NVARCHAR(max) NOT NULL,
    [Steuerungsvorgabe] NVARCHAR(max),
    [Vermieter] NVARCHAR(max),
    [Anlieferungszeitpunkt] DATETIME2,
    [MietwagenTyp] NVARCHAR(max) NOT NULL,
    [RueckgabeZeitpunkt] DATETIME2,
    [Reservierungsnummer] NVARCHAR(max),
    [Kommentar] NVARCHAR(max),
    [VersicherungId] INT,
    [DienstleisterId] INT,
    [ClaimDocumentExportId] INT,
    [IstAktiv] BIT,
    [IstAktivGueltigAb] DATETIME2,
    [IstAktivGueltigBis] DATETIME2,
    [SchadenortTypId] INT,
    [Kostenstelle1] NVARCHAR(max),
    [Kostenstelle1GueltigAb] DATETIME2,
    [Kostenstelle2] NVARCHAR(max),
    [Kostenstelle2GueltigAb] DATETIME2,
    [Rueckgabeort] VARCHAR(max),
    [GutachterBesichtigungstermin] DATETIME2,
    [SchadenstatusBegruendung] NVARCHAR(max) NOT NULL,
    [Bemerkung1] NVARCHAR(max),
    [Bemerkung2] NVARCHAR(max),
    [BilderErhalten] BIT,
    [FreigabeFuhrpark] BIT,
    [FreigabeLeasing] BIT,
    [FreigabeVU] BIT,
    [SGSBilder] BIT,
    [GutachtenErhalten] BIT,
    [RueckgabeErfolgt] BIT,
    [FreigabeMakler] BIT,
    [FreigabeNutzer] BIT,
    [FremdNummer] NVARCHAR(max),
    [SSHBilder] BIT,
    [Email] NVARCHAR(max),
    [Mobil] NVARCHAR(max),
    [Ort] NVARCHAR(max),
    [Plz] NVARCHAR(max),
    [Strasse] NVARCHAR(max),
    [Telefon] NVARCHAR(max),
    [WerkstattInfo] NVARCHAR(max),
    [PeriodEnd] DATETIME2 NOT NULL,
    [PeriodStart] DATETIME2 NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[Schadennummer] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [NumericPart] BIGINT,
    CONSTRAINT [PK_Schadennummer] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[SchadenortTyp] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Bezeichnung] NVARCHAR(250),
    CONSTRAINT [PK_SchadenortTyp] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ScheduleAppointment] (
    [ScheduleAppointmentId] INT NOT NULL IDENTITY(1,1),
    [Subject] NVARCHAR(max),
    [Location] NVARCHAR(max),
    [StartTime] DATETIME2 NOT NULL,
    [EndTime] DATETIME2 NOT NULL,
    [Description] NVARCHAR(max),
    [IsAllDay] BIT NOT NULL,
    [RecurrenceRule] NVARCHAR(max),
    [RecurrenceException] NVARCHAR(max),
    [RecurrenceID] INT,
    [Status] NVARCHAR(max),
    [Priority] NVARCHAR(max),
    [VorgangId] INT,
    CONSTRAINT [PK_ScheduleAppointment] PRIMARY KEY CLUSTERED ([ScheduleAppointmentId])
);

-- CreateTable
CREATE TABLE [dbo].[SearchAttribute] (
    [SearchAttributeId] INT NOT NULL IDENTITY(1,1),
    [Entity] NVARCHAR(max),
    [SearchAttributeName] NVARCHAR(max),
    [ImportTemplateTemplateId] INT NOT NULL,
    [DisplayName] NVARCHAR(max),
    CONSTRAINT [PK_SearchAttribute] PRIMARY KEY CLUSTERED ([SearchAttributeId])
);

-- CreateTable
CREATE TABLE [dbo].[SentMails] (
    [SentMailId] INT NOT NULL IDENTITY(1,1),
    [MessageId] NVARCHAR(max),
    [EmailFrom] NVARCHAR(max),
    [EmailSubject] NVARCHAR(max),
    [EmailTo] NVARCHAR(max),
    [DocumentId] INT NOT NULL,
    [DocumentType] INT NOT NULL,
    [DocumentVault] NVARCHAR(max),
    [EmailMsg] NVARCHAR(max),
    [Kennzeichen] NVARCHAR(max),
    [SchadenId] INT,
    [SchadenNummer] NVARCHAR(max),
    [Uhrzeit] DATETIME2 NOT NULL,
    CONSTRAINT [PK_SentMails] PRIMARY KEY CLUSTERED ([SentMailId])
);

-- CreateTable
CREATE TABLE [dbo].[Stundenverrechnungssaetze] (
    [StundenverrechnungssatzId] INT NOT NULL IDENTITY(1,1),
    [SvsName] NVARCHAR(max),
    [SvsLack] DECIMAL(18,2) NOT NULL,
    [SvsMechanik] DECIMAL(18,2) NOT NULL,
    [SvsKarosserie] DECIMAL(18,2) NOT NULL,
    [SvsLackMaterial] DECIMAL(18,2),
    [SvsLackart] NVARCHAR(max),
    [SvsEtAufschlag] DECIMAL(18,2) NOT NULL,
    [SvsVerbringung] DECIMAL(18,2) NOT NULL,
    [SvsVorgabe] BIT NOT NULL,
    [SvsAbweichungVonVorgabe] DECIMAL(18,2) NOT NULL,
    [SvsTypId] INT,
    [KundeTenantItemId] INT,
    [KonzernId] INT,
    [SvsTypName] NVARCHAR(max),
    [DienstleisterId] INT NOT NULL,
    CONSTRAINT [PK_Stundenverrechnungssaetze] PRIMARY KEY CLUSTERED ([StundenverrechnungssatzId])
);

-- CreateTable
CREATE TABLE [dbo].[SvsTyp] (
    [SvsTypId] INT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(450),
    [AutarkerSvs] BIT,
    [DekraAufAbschlag] DECIMAL(18,2),
    CONSTRAINT [PK_SvsTyp] PRIMARY KEY CLUSTERED ([SvsTypId])
);

-- CreateTable
CREATE TABLE [dbo].[sysdiagrams] (
    [name] NVARCHAR(128) NOT NULL,
    [principal_id] INT NOT NULL,
    [diagram_id] INT NOT NULL IDENTITY(1,1),
    [version] INT,
    [definition] VARBINARY(max),
    CONSTRAINT [PK__sysdiagr__C2B05B61CE72FA26] PRIMARY KEY CLUSTERED ([diagram_id])
);

-- CreateTable
CREATE TABLE [dbo].[Tankdaten] (
    [TankkartenId] INT NOT NULL IDENTITY(1,1),
    [Karte] NVARCHAR(max),
    [Kartenzusatz] NVARCHAR(max),
    [Kennzeichen] NVARCHAR(max),
    [Fahrer] NVARCHAR(max),
    [Km_Stand] INT NOT NULL,
    [Lieferdatum] DATETIME2,
    [Abrechnungsdatum] DATETIME2,
    [Beleg_Nr] NVARCHAR(max) NOT NULL,
    [Erfassungsart] NVARCHAR(max),
    [Land] NVARCHAR(max),
    [SST] NVARCHAR(max),
    [PLZStation] NVARCHAR(max),
    [Marke] NVARCHAR(max),
    [Ort] NVARCHAR(max),
    [Warenart] NVARCHAR(max),
    [Warencode] NVARCHAR(max),
    [Warengruppe] NVARCHAR(max),
    [Menge] DECIMAL(18,2) NOT NULL,
    [Preis] FLOAT(53) NOT NULL,
    [Einheit] NVARCHAR(max),
    [Betrag] DECIMAL(18,2) NOT NULL,
    [NachlassinclUSt] DECIMAL(18,2) NOT NULL,
    [FeeinclUSt] DECIMAL(18,2) NOT NULL,
    [WertinclUSt] DECIMAL(18,2) NOT NULL,
    [USt] NVARCHAR(max),
    [BetragUSt] DECIMAL(18,2) NOT NULL,
    [NachlassexclUSt] DECIMAL(18,2) NOT NULL,
    [FeeexclUSt] DECIMAL(18,2) NOT NULL,
    [WertexclUSt] DECIMAL(18,2) NOT NULL,
    [Rechnung] NVARCHAR(max),
    [Kostenstelle] NVARCHAR(max),
    [Autohof] BIT,
    [Autobahntankstelle] BIT,
    [Stra├ƒentankstelle] BIT,
    [Kommentar] NVARCHAR(max),
    [ObuId] FLOAT(53),
    [FahrzeugTenantItemId] INT,
    [KundeTenantItemId] INT,
    CONSTRAINT [PK_Tankdaten] PRIMARY KEY CLUSTERED ([TankkartenId])
);

-- CreateTable
CREATE TABLE [dbo].[TeileBestellungen] (
    [TeileBestellungId] INT NOT NULL IDENTITY(1,1),
    [Datum] DATETIME2 NOT NULL,
    [BestellNummer] NVARCHAR(max),
    [Auftragsnummer] NVARCHAR(max),
    [Vin] NVARCHAR(max),
    [KbaNummer] NVARCHAR(max),
    [Kennzeichen] NVARCHAR(max),
    [Erstzulassung] DATETIME2 NOT NULL,
    [Hersteller] NVARCHAR(max),
    [Eingangsdatum] DATETIME2 NOT NULL,
    [Gesamtkosten] DECIMAL(18,2) NOT NULL,
    [UniqueBestellungId] NVARCHAR(max),
    [UebergabePartsDatumUhrzeit] DATETIME2 NOT NULL,
    [UebergebenAnParts] BIT NOT NULL,
    [BestellerName] NVARCHAR(max),
    [BestellerOrt] NVARCHAR(max),
    [BestellerStrasse] NVARCHAR(max),
    [MfilesId] INT,
    [MfilesType] INT,
    CONSTRAINT [PK_TeileBestellungen] PRIMARY KEY CLUSTERED ([TeileBestellungId])
);

-- CreateTable
CREATE TABLE [dbo].[TeileBestellungGesamt] (
    [TeileBestellungGesamtId] INT NOT NULL IDENTITY(1,1),
    [Bezeichnung] NVARCHAR(max),
    [Gesamtbetrag] DECIMAL(18,2) NOT NULL,
    [TeileBestellungId] INT,
    CONSTRAINT [PK_TeileBestellungGesamt] PRIMARY KEY CLUSTERED ([TeileBestellungGesamtId])
);

-- CreateTable
CREATE TABLE [dbo].[TeileBestellungPositionen] (
    [TeileBestellungPositionId] INT NOT NULL IDENTITY(1,1),
    [Anzahl] INT NOT NULL,
    [ArtikelNummer] NVARCHAR(max),
    [Beschreibung] NVARCHAR(max),
    [Menge] INT NOT NULL,
    [TeileBestellungId] INT,
    [EPreis] DECIMAL(18,2) NOT NULL,
    [GPreis] DECIMAL(18,2) NOT NULL,
    CONSTRAINT [PK_TeileBestellungPositionen] PRIMARY KEY CLUSTERED ([TeileBestellungPositionId])
);

-- CreateTable
CREATE TABLE [dbo].[Unfallgegner] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [KennzeichenKfz] NVARCHAR(max),
    [KennzeichenAnhaenger] NVARCHAR(max),
    [HerstellerModell] NVARCHAR(max),
    [Haltername] NVARCHAR(max),
    [Strasse] NVARCHAR(max),
    [Hausnummer] NVARCHAR(max),
    [Plz] NVARCHAR(max),
    [Ort] NVARCHAR(max),
    CONSTRAINT [PK_Unfallgegner] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[UploadFiles] (
    [UploadFileId] INT NOT NULL IDENTITY(1,1),
    [Filename] NVARCHAR(max) NOT NULL,
    [UploadIdentifier] UNIQUEIDENTIFIER NOT NULL,
    [UserId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_UploadFiles] PRIMARY KEY CLUSTERED ([UploadFileId])
);

-- CreateTable
CREATE TABLE [dbo].[UserRegistration] (
    [UserRegistrationId] INT NOT NULL IDENTITY(1,1),
    [EmailAddress] NVARCHAR(max) NOT NULL,
    [UniqueCode] NVARCHAR(max) NOT NULL,
    CONSTRAINT [PK_UserRegistration] PRIMARY KEY CLUSTERED ([UserRegistrationId])
);

-- CreateTable
CREATE TABLE [dbo].[ValidTenants] (
    [ValidTenantId] INT NOT NULL IDENTITY(1,1),
    [TenantId] INT NOT NULL,
    [BenutzergruppeId] INT NOT NULL,
    CONSTRAINT [PK_ValidTenants] PRIMARY KEY CLUSTERED ([ValidTenantId])
);

-- CreateTable
CREATE TABLE [dbo].[Versicherung] (
    [VersicherungId] INT NOT NULL IDENTITY(1,1),
    [InNuceKeyVersicherung] NVARCHAR(max),
    [Bezeichnung] NVARCHAR(max),
    [Beginn] DATETIME2,
    [Ende] DATETIME2,
    [Beschreibung] NVARCHAR(max),
    [VersicherungGesamt] FLOAT(53) NOT NULL,
    [Gruppenversicherung] BIT,
    [HaftpflichtGesamt] FLOAT(53) NOT NULL,
    [VsVK] FLOAT(53),
    [SbVK] FLOAT(53),
    [SbTK] FLOAT(53),
    [GAPVersicherung] FLOAT(53) NOT NULL,
    [VsInsassen] FLOAT(53),
    [VsRS] FLOAT(53),
    [VsSB] FLOAT(53),
    [Rueckstellungspraemie] FLOAT(53),
    [VuNummer] INT,
    [VuName] NVARCHAR(max),
    [Vertragsnummer] NVARCHAR(max),
    [Freigabe2500] BIT,
    [EmailVu] NVARCHAR(max),
    [GutachterVu] BIT,
    [TelefonVu] NVARCHAR(max),
    [WerkstattPrio] BIT,
    [Pickup] BIT,
    [PoolPrio] BIT,
    [VsKH] FLOAT(53),
    [VsTK] FLOAT(53),
    [VsIU] FLOAT(53),
    [VsSchutz] FLOAT(53),
    [SbKH] FLOAT(53),
    [SbIU] FLOAT(53),
    [SbSchutz] FLOAT(53),
    [BedKH] NVARCHAR(max),
    [BedVK] NVARCHAR(max),
    [BedTK] NVARCHAR(max),
    [BedIU] NVARCHAR(max),
    [BedSchutz] NVARCHAR(max),
    [KundeTenantItemId] INT NOT NULL,
    [FahrzeugTenantItemId] INT,
    [VersicherungsdienstleisterDienstleisterId] INT,
    [IstAktivGueltigBis] DATETIME2,
    [BeitragIU] FLOAT(53),
    [BeitragKH] FLOAT(53),
    [BeitragSchutz] FLOAT(53),
    [BeitragTK] FLOAT(53),
    [BeitragVK] FLOAT(53),
    [Jahresbeitrag] FLOAT(53),
    [Zahlweise] NVARCHAR(max),
    [ExternalDataField] VARCHAR(max),
    CONSTRAINT [PK_Versicherung] PRIMARY KEY CLUSTERED ([VersicherungId])
);

-- CreateTable
CREATE TABLE [dbo].[Vorgang] (
    [VorgangId] INT NOT NULL IDENTITY(1,1),
    [VorgangTyp] NVARCHAR(max),
    [Name] NVARCHAR(max),
    [IstAktiv] BIT NOT NULL,
    [GeplanteAktivierung] DATETIME2,
    [LetzteAktivierung] DATETIME2,
    [AnsprechpartnerId] INT,
    [SchadenId] INT,
    [DienstleisterId] INT,
    [FahrzeugTenantItemId] INT,
    [ActivationEventEventId] INT,
    [ActivationType] NVARCHAR(max),
    CONSTRAINT [PK_Vorgang] PRIMARY KEY CLUSTERED ([VorgangId])
);

-- CreateTable
CREATE TABLE [dbo].[Vorgangsschritt] (
    [VorgangsschrittId] INT NOT NULL IDENTITY(1,1),
    [Reihenfolge] INT NOT NULL,
    [SchrittTyp] NVARCHAR(max),
    [SchrittName] NVARCHAR(max),
    [SchrittWert] NVARCHAR(max),
    [VorgangId] INT,
    [External] NVARCHAR(max),
    [Internal] NVARCHAR(max),
    CONSTRAINT [PK_Vorgangsschritt] PRIMARY KEY CLUSTERED ([VorgangsschrittId])
);

-- CreateTable
CREATE TABLE [dbo].[VorlagenZuordnung] (
    [VorlagenZuordnungId] INT NOT NULL IDENTITY(1,1),
    [VorlagenName] NVARCHAR(max),
    [HeaderName] NVARCHAR(max),
    [FooterName] NVARCHAR(max),
    [UnterzeichnerLinks] NVARCHAR(max),
    [UnterzeichnerRechts] NVARCHAR(max),
    [AnsprechpartnerId] INT NOT NULL,
    CONSTRAINT [PK_VorlagenZuordnung] PRIMARY KEY CLUSTERED ([VorlagenZuordnungId])
);

-- CreateTable
CREATE TABLE [dbo].[Werkstatt] (
    [WerkstattId] INT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(max) NOT NULL,
    [Schluessel] NVARCHAR(max),
    [IstAktiv] BIT,
    [DekraMechanik] FLOAT(53),
    [DekraKarosserie] FLOAT(53),
    [DekraLack] FLOAT(53),
    [SvsGeprueft] BIT,
    [DekraMechanikHLA] FLOAT(53),
    [DekraKarosserieHLA] FLOAT(53),
    [DekraLackHLA] FLOAT(53),
    [Anmerkungen] NVARCHAR(max),
    [NeuerVertrag] BIT,
    [WerkstattTyp] NVARCHAR(max),
    [Dienstleisterart] INT NOT NULL,
    [Matchcode] NVARCHAR(max),
    [Favorit] INT,
    CONSTRAINT [PK_Werkstatt] PRIMARY KEY CLUSTERED ([WerkstattId])
);

-- CreateTable
CREATE TABLE [dbo].[WerkstattKundennummer] (
    [WerkstattKundennummerId] INT NOT NULL IDENTITY(1,1),
    [Lieferant] NVARCHAR(max),
    [LieferantKundennummer] NVARCHAR(max),
    [WerkstattDienstleisterId] INT,
    CONSTRAINT [PK_WerkstattKundennummer] PRIMARY KEY CLUSTERED ([WerkstattKundennummerId])
);

-- CreateTable
CREATE TABLE [dbo].[WfProcessed] (
    [WfProcessedId] INT NOT NULL IDENTITY(1,1),
    [KundeId] INT,
    [FahrzeugId] INT,
    [SchadenId] INT,
    [WfRules] NVARCHAR(max),
    [ActionDatasource] NVARCHAR(max),
    [RuleBereich] NVARCHAR(50),
    [RuleName] NVARCHAR(50),
    CONSTRAINT [PK_WfProcessed] PRIMARY KEY CLUSTERED ([WfProcessedId])
);

-- CreateTable
CREATE TABLE [dbo].[WfProperty] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(max),
    [Value] NVARCHAR(max),
    [WfStateId] INT NOT NULL,
    CONSTRAINT [PK_WfProperty] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateIndex
CREATE NONCLUSTERED INDEX [DF__Kunden__Kundenco__542C7691] ON [dbo].[Kunden]([Kundencode]);

-- CreateIndex
CREATE CLUSTERED INDEX [ix_RegelwerkHistory] ON [dbo].[RegelwerkHistory]([PeriodEnd], [PeriodStart]);

-- AddForeignKey
ALTER TABLE [dbo].[Arbeitszeit] ADD CONSTRAINT [FK_Arbeitszeit_Kostenvoranschlag_KostenvoranschlagId] FOREIGN KEY ([KostenvoranschlagId]) REFERENCES [dbo].[Kostenvoranschlag]([KostenvoranschlagId]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Benutzer] ADD CONSTRAINT [Benutzer_KundeTenantItemId_fkey] FOREIGN KEY ([KundeTenantItemId]) REFERENCES [dbo].[Kunden]([TenantItemId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Benutzers] ADD CONSTRAINT [Benutzers_UserId_fkey] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Benutzer]([UserId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Buchungsposition] ADD CONSTRAINT [FK_Buchungsposition_Schaden_SchadenId] FOREIGN KEY ([SchadenId]) REFERENCES [dbo].[Schaden]([Id]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[DataFieldConfigs] ADD CONSTRAINT [FK_DataFieldConfigs_ImportTemplates_ImportTemplateTemplateId] FOREIGN KEY ([ImportTemplateTemplateId]) REFERENCES [dbo].[ImportTemplates]([TemplateId]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[DbFieldMapping] ADD CONSTRAINT [FK_DbFieldMapping_DbModels_DbModelId] FOREIGN KEY ([DbModelId]) REFERENCES [dbo].[DbModels]([DbModelId]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Dienstleistungspauschalen] ADD CONSTRAINT [FK_Dienstleistungspauschalen_Dienstleister_DienstleisterId] FOREIGN KEY ([DienstleisterId]) REFERENCES [dbo].[Dienstleister]([DienstleisterId]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Dienstleistungspauschalen] ADD CONSTRAINT [FK_Dienstleistungspauschalen_Kunden_KundeTenantItemId] FOREIGN KEY ([KundeTenantItemId]) REFERENCES [dbo].[Kunden]([TenantItemId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[DriversCheckEmployees] ADD CONSTRAINT [FK_DriversCheckEmployees_DriversCheckCheckups_DriversCheckCheckupId] FOREIGN KEY ([DriversCheckCheckupId]) REFERENCES [dbo].[DriversCheckCheckups]([DriversCheckCheckupId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[DriversCheckEmployees] ADD CONSTRAINT [FK_DriversCheckEmployees_DriversCheckDriverLicenses_DriversCheckDriverLicenseId] FOREIGN KEY ([DriversCheckDriverLicenseId]) REFERENCES [dbo].[DriversCheckDriverLicenses]([DriversCheckDriverLicenseId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[DriversCheckEmployees] ADD CONSTRAINT [FK_DriversCheckEmployees_DriversCheckModules_DriversCheckModulesId] FOREIGN KEY ([DriversCheckModulesId]) REFERENCES [dbo].[DriversCheckModules]([DriversCheckModulesId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[DriversCheckEmployees] ADD CONSTRAINT [FK_DriversCheckEmployees_DriversCheckPrivileges_DriversCheckPrivilegesId] FOREIGN KEY ([DriversCheckPrivilegesId]) REFERENCES [dbo].[DriversCheckPrivileges]([DriversCheckPrivilegesId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[DriversCheckEmployees] ADD CONSTRAINT [FK_DriversCheckEmployees_Fahrer_FahrerId] FOREIGN KEY ([FahrerId]) REFERENCES [dbo].[Fahrer]([FahrerId]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[DriversCheckOrganizations] ADD CONSTRAINT [FK_DriversCheckOrganizations_DriversCheckOrganizationCheckups_DriversCheckOrganizationCheckupId] FOREIGN KEY ([DriversCheckOrganizationCheckupId]) REFERENCES [dbo].[DriversCheckOrganizationCheckups]([DriversCheckOrganizationCheckupId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[EnumImportConfigs] ADD CONSTRAINT [FK_EnumImportConfigs_ImportTemplates_ImportTemplateTemplateId] FOREIGN KEY ([ImportTemplateTemplateId]) REFERENCES [dbo].[ImportTemplates]([TemplateId]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Ersatzteil] ADD CONSTRAINT [FK_Ersatzteil_Kostenvoranschlag_KostenvoranschlagId] FOREIGN KEY ([KostenvoranschlagId]) REFERENCES [dbo].[Kostenvoranschlag]([KostenvoranschlagId]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Fahrer] ADD CONSTRAINT [FK_Fahrer_Kunden_KundeTenantItemId] FOREIGN KEY ([KundeTenantItemId]) REFERENCES [dbo].[Kunden]([TenantItemId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[FahrerFahrzeug] ADD CONSTRAINT [FK_FahrerFahrzeug_Fahrer_FahrerId] FOREIGN KEY ([FahrerId]) REFERENCES [dbo].[Fahrer]([FahrerId]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[FahrzeugbelegKategorien] ADD CONSTRAINT [FK_FahrzeugbelegKategorien_FahrzeugbelegKategorieTypen_FahrzeugbelegKategorieTypId] FOREIGN KEY ([FahrzeugbelegKategorieTypId]) REFERENCES [dbo].[FahrzeugbelegKategorieTypen]([FahrzeugbelegKategorieTypId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Fahrzeugbelegpositionen] ADD CONSTRAINT [FK_Fahrzeugbelegpositionen_FahrzeugbelegpositionsBezeichnungen_FahrzeugbelegpositionsBezeichnungId] FOREIGN KEY ([FahrzeugbelegpositionsBezeichnungId]) REFERENCES [dbo].[FahrzeugbelegpositionsBezeichnungen]([FahrzeugbelegpositionsBezeichnungId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Fahrzeuge] ADD CONSTRAINT [FK_Fahrzeuge_Dienstleister_LieferantDienstleisterId] FOREIGN KEY ([LieferantDienstleisterId]) REFERENCES [dbo].[Dienstleister]([DienstleisterId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Fahrzeuge] ADD CONSTRAINT [FK_Fahrzeuge_Dienstleister_ReifenDienstleisterDienstleisterId] FOREIGN KEY ([ReifenDienstleisterDienstleisterId]) REFERENCES [dbo].[Dienstleister]([DienstleisterId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Fahrzeuge] ADD CONSTRAINT [FK_Fahrzeuge_Fahrzeugtyp_FahrzeugtypId] FOREIGN KEY ([FahrzeugtypId]) REFERENCES [dbo].[Fahrzeugtyp]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Fahrzeuge] ADD CONSTRAINT [FK_Fahrzeuge_Gruppenversicherung_GruppenversicherungId] FOREIGN KEY ([GruppenversicherungId]) REFERENCES [dbo].[Gruppenversicherung]([GruppenversicherungId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Fahrzeuge] ADD CONSTRAINT [FK_Fahrzeuge_Gruppenversicherungsvertrag_GruppenversicherungsvertragId] FOREIGN KEY ([GruppenversicherungsvertragId]) REFERENCES [dbo].[Gruppenversicherungsvertrag]([GruppenversicherungsvertragId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Fahrzeuge] ADD CONSTRAINT [FK_Fahrzeuge_Kaufvertrags_KaufvertragId] FOREIGN KEY ([KaufvertragId]) REFERENCES [dbo].[Kaufvertrags]([KaufvertragId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Fahrzeuge] ADD CONSTRAINT [FK_Fahrzeuge_Kunden_KundeTenantItemId] FOREIGN KEY ([KundeTenantItemId]) REFERENCES [dbo].[Kunden]([TenantItemId]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Fahrzeuge] ADD CONSTRAINT [FK_Fahrzeuge_Mietvertrag_MietvertragId] FOREIGN KEY ([MietvertragId]) REFERENCES [dbo].[Mietvertrag]([MietvertragId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Gruppenmitglieder] ADD CONSTRAINT [FK_Gruppenmitglieder_Arbeitsgruppen_ArbeitsgruppeId] FOREIGN KEY ([ArbeitsgruppeId]) REFERENCES [dbo].[Arbeitsgruppen]([ArbeitsgruppeId]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Gruppenversicherung] ADD CONSTRAINT [FK_Gruppenversicherung_Dienstleister_VersicherungsdienstleisterDienstleisterId] FOREIGN KEY ([VersicherungsdienstleisterDienstleisterId]) REFERENCES [dbo].[Dienstleister]([DienstleisterId]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Gruppenversicherung] ADD CONSTRAINT [FK_Gruppenversicherung_Kunden_KundeTenantItemId] FOREIGN KEY ([KundeTenantItemId]) REFERENCES [dbo].[Kunden]([TenantItemId]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ImplCategories] ADD CONSTRAINT [FK_ImplCategories_Kunden_KundeTenantItemId] FOREIGN KEY ([KundeTenantItemId]) REFERENCES [dbo].[Kunden]([TenantItemId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ImplProperties] ADD CONSTRAINT [FK_ImplProperties_ImplSubCategories_ImplSubCategoryId] FOREIGN KEY ([ImplSubCategoryId]) REFERENCES [dbo].[ImplSubCategories]([ImplSubCategoryId]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ImplProperties] ADD CONSTRAINT [FK_ImplProperties_Kunden_KundeTenantItemId] FOREIGN KEY ([KundeTenantItemId]) REFERENCES [dbo].[Kunden]([TenantItemId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ImplSubCategories] ADD CONSTRAINT [FK_ImplSubCategories_ImplCategories_ImplCategoryId] FOREIGN KEY ([ImplCategoryId]) REFERENCES [dbo].[ImplCategories]([ImplCategoryId]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ImplSubCategories] ADD CONSTRAINT [FK_ImplSubCategories_Kunden_KundeTenantItemId] FOREIGN KEY ([KundeTenantItemId]) REFERENCES [dbo].[Kunden]([TenantItemId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ImportPropertyMaps] ADD CONSTRAINT [FK_ImportPropertyMaps_ImportTemplates_ImportTemplateTemplateId] FOREIGN KEY ([ImportTemplateTemplateId]) REFERENCES [dbo].[ImportTemplates]([TemplateId]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Kaufvertrags] ADD CONSTRAINT [FK_Kaufvertrags_Kunden_KundeTenantItemId] FOREIGN KEY ([KundeTenantItemId]) REFERENCES [dbo].[Kunden]([TenantItemId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[KontaktBeziehungen] ADD CONSTRAINT [FK_KontaktBeziehungen_KontaktBeziehungen_ParentKontaktBeziehungId] FOREIGN KEY ([ParentKontaktBeziehungId]) REFERENCES [dbo].[KontaktBeziehungen]([KontaktBeziehungId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[KontaktBeziehungen] ADD CONSTRAINT [FK_KontaktBeziehungen_Kunden_KundeTenantItemId] FOREIGN KEY ([KundeTenantItemId]) REFERENCES [dbo].[Kunden]([TenantItemId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Kostenvoranschlag] ADD CONSTRAINT [FK_Kostenvoranschlag_Schaden_SchadenId] FOREIGN KEY ([SchadenId]) REFERENCES [dbo].[Schaden]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Lackmaterial] ADD CONSTRAINT [FK_Lackmaterial_Kostenvoranschlag_KostenvoranschlagId] FOREIGN KEY ([KostenvoranschlagId]) REFERENCES [dbo].[Kostenvoranschlag]([KostenvoranschlagId]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Leasingrechnung] ADD CONSTRAINT [FK_Leasingrechnung_Fahrzeuge_FahrzeugTenantItemId] FOREIGN KEY ([FahrzeugTenantItemId]) REFERENCES [dbo].[Fahrzeuge]([TenantItemId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Nebenkosten] ADD CONSTRAINT [FK_Nebenkosten_Kostenvoranschlag_KostenvoranschlagId] FOREIGN KEY ([KostenvoranschlagId]) REFERENCES [dbo].[Kostenvoranschlag]([KostenvoranschlagId]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Regelwerk] ADD CONSTRAINT [FK_Regelwerk_Kunden_KundeTenantItemId] FOREIGN KEY ([KundeTenantItemId]) REFERENCES [dbo].[Kunden]([TenantItemId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH

