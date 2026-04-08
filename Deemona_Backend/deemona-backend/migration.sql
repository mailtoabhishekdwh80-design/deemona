-- ============================================================
--  DEEMONA — Complete MySQL Schema (replaces all SQL Server migrations)
--  Run once via: node scripts/setupDb.js
--  Or manually:  mysql -u root -p < migration.sql
-- ============================================================

CREATE DATABASE IF NOT EXISTS deemona CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE deemona;

-- ── Categories ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS Categories (
  CategoryID       INT AUTO_INCREMENT PRIMARY KEY,
  CategoryName     VARCHAR(100) NOT NULL UNIQUE,
  Description      TEXT,
  ParentCategoryID INT NULL,
  IsActive         TINYINT(1) NOT NULL DEFAULT 1,
  CreatedAt        DATETIME NOT NULL DEFAULT NOW(),
  FOREIGN KEY (ParentCategoryID) REFERENCES Categories(CategoryID)
) ENGINE=InnoDB;

-- ── Suppliers ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS Suppliers (
  SupplierID   INT AUTO_INCREMENT PRIMARY KEY,
  CompanyName  VARCHAR(200) NOT NULL,
  ContactName  VARCHAR(100),
  ContactEmail VARCHAR(255),
  Phone        VARCHAR(20),
  Address      TEXT,
  City         VARCHAR(100),
  Country      VARCHAR(100) DEFAULT 'India',
  IsActive     TINYINT(1) NOT NULL DEFAULT 1,
  CreatedAt    DATETIME NOT NULL DEFAULT NOW()
) ENGINE=InnoDB;

-- ── Customers ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS Customers (
  CustomerID              INT AUTO_INCREMENT PRIMARY KEY,
  FirstName               VARCHAR(100) NOT NULL,
  LastName                VARCHAR(100) NOT NULL,
  Email                   VARCHAR(255) NOT NULL UNIQUE,
  PhoneNumber             VARCHAR(20),
  PasswordHash            VARCHAR(255) NOT NULL,
  Address                 TEXT,
  City                    VARCHAR(100),
  State                   VARCHAR(100),
  PostalCode              VARCHAR(20),
  Country                 VARCHAR(100) DEFAULT 'India',
  LoyaltyPoints           INT NOT NULL DEFAULT 0,
  LoyaltyTier             ENUM('Bronze','Silver','Gold','Platinum') NOT NULL DEFAULT 'Bronze',
  PreferredPaymentMethod  VARCHAR(50),
  AccountStatus           ENUM('active','inactive','suspended','deleted') NOT NULL DEFAULT 'active',
  FailedLoginAttempts     INT NOT NULL DEFAULT 0,
  LockedUntil             DATETIME NULL,
  TwoFAEnabled            TINYINT(1) NOT NULL DEFAULT 0,
  TwoFASecret             VARCHAR(64) NULL,
  DateOfBirth             DATE NULL,
  BirthdayPointsLastGiven DATE NULL,
  PasswordResetToken      VARCHAR(64) NULL,
  PasswordResetExpiry     DATETIME NULL,
  AbandonedEmailSent      DATETIME NULL,
  RegistrationDate        DATETIME NOT NULL DEFAULT NOW(),
  LastLogin               DATETIME NULL,
  UpdatedAt               DATETIME NULL,
  INDEX idx_email (Email),
  INDEX idx_status (AccountStatus),
  INDEX idx_tier (LoyaltyTier)
) ENGINE=InnoDB;

-- ── AdminUsers ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS AdminUsers (
  AdminID        INT AUTO_INCREMENT PRIMARY KEY,
  FirstName      VARCHAR(100) NOT NULL,
  LastName       VARCHAR(100) NOT NULL,
  Email          VARCHAR(255) NOT NULL UNIQUE,
  PasswordHash   VARCHAR(255) NOT NULL,
  Role           ENUM('super_admin','admin','manager','support') NOT NULL DEFAULT 'support',
  IsActive       TINYINT(1) NOT NULL DEFAULT 1,
  TwoFAEnabled   TINYINT(1) NOT NULL DEFAULT 0,
  TwoFASecret    VARCHAR(64) NULL,
  FailedAttempts INT NOT NULL DEFAULT 0,
  LockedUntil    DATETIME NULL,
  LastLogin      DATETIME NULL,
  CreatedAt      DATETIME NOT NULL DEFAULT NOW()
) ENGINE=InnoDB;

-- ── RefreshTokens ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS RefreshTokens (
  TokenID    INT AUTO_INCREMENT PRIMARY KEY,
  UserID     INT NOT NULL,
  UserType   ENUM('customer','admin') NOT NULL DEFAULT 'customer',
  TokenHash  VARCHAR(64) NOT NULL UNIQUE,
  IsRevoked  TINYINT(1) NOT NULL DEFAULT 0,
  ExpiresAt  DATETIME NOT NULL,
  IPAddress  VARCHAR(45) NULL,
  UserAgent  VARCHAR(200) NULL,
  CreatedAt  DATETIME NOT NULL DEFAULT NOW(),
  RevokedAt  DATETIME NULL,
  INDEX idx_hash (TokenHash),
  INDEX idx_user (UserID, UserType)
) ENGINE=InnoDB;

-- ── TokenDenylist ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS TokenDenylist (
  ID        INT AUTO_INCREMENT PRIMARY KEY,
  JTI       VARCHAR(36) NOT NULL UNIQUE,
  ExpiresAt DATETIME NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT NOW(),
  INDEX idx_jti (JTI),
  INDEX idx_exp (ExpiresAt)
) ENGINE=InnoDB;

-- ── AdminActivityLog ──────────────────────────────────────
CREATE TABLE IF NOT EXISTS AdminActivityLog (
  LogID      INT AUTO_INCREMENT PRIMARY KEY,
  AdminID    INT NOT NULL,
  Action     VARCHAR(100) NOT NULL,
  EntityType VARCHAR(50) NULL,
  EntityID   INT NULL,
  Details    TEXT NULL,
  IPAddress  VARCHAR(45) NULL,
  UserAgent  VARCHAR(200) NULL,
  CreatedAt  DATETIME NOT NULL DEFAULT NOW(),
  FOREIGN KEY (AdminID) REFERENCES AdminUsers(AdminID)
) ENGINE=InnoDB;

-- ── Products ──────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS Products (
  ProductID      INT AUTO_INCREMENT PRIMARY KEY,
  Name           VARCHAR(300) NOT NULL,
  Description    TEXT,
  SKU            VARCHAR(100) UNIQUE,
  Brand          VARCHAR(100),
  CategoryID     INT NULL,
  SupplierID     INT NULL,
  Price          DECIMAL(10,2) NOT NULL,
  MRP            DECIMAL(10,2) NOT NULL,
  CostPrice      DECIMAL(10,2) NULL,
  StockQuantity  INT NOT NULL DEFAULT 0,
  ReorderLevel   INT NOT NULL DEFAULT 10,
  ReservedQty    INT NOT NULL DEFAULT 0,
  Weight         DECIMAL(8,3) NULL,
  Dimensions     VARCHAR(100) NULL,
  ImageURLs      TEXT NULL,
  Tags           TEXT NULL,
  AverageRating  DECIMAL(3,2) NOT NULL DEFAULT 0,
  ReviewsCount   INT NOT NULL DEFAULT 0,
  ViewsCount     INT NOT NULL DEFAULT 0,
  IsFeatured     TINYINT(1) NOT NULL DEFAULT 0,
  IsActive       TINYINT(1) NOT NULL DEFAULT 1,
  ShowPublicly   TINYINT(1) NOT NULL DEFAULT 1,
  CreatedAt      DATETIME NOT NULL DEFAULT NOW(),
  UpdatedAt      DATETIME NULL,
  FOREIGN KEY (CategoryID)  REFERENCES Categories(CategoryID),
  FOREIGN KEY (SupplierID)  REFERENCES Suppliers(SupplierID),
  INDEX idx_category (CategoryID),
  INDEX idx_active (IsActive),
  INDEX idx_featured (IsFeatured),
  FULLTEXT idx_search (Name, Description, Brand, Tags)
) ENGINE=InnoDB;

-- ── ProductPriceHistory ───────────────────────────────────
CREATE TABLE IF NOT EXISTS ProductPriceHistory (
  HistoryID     INT AUTO_INCREMENT PRIMARY KEY,
  ProductID     INT NOT NULL,
  OldPrice      DECIMAL(10,2) NOT NULL,
  NewPrice      DECIMAL(10,2) NOT NULL,
  ChangedAt     DATETIME NOT NULL DEFAULT NOW(),
  ChangeReason  VARCHAR(200) NULL,
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
) ENGINE=InnoDB;

-- ── StockAdjustments ─────────────────────────────────────
CREATE TABLE IF NOT EXISTS StockAdjustments (
  AdjustmentID INT AUTO_INCREMENT PRIMARY KEY,
  ProductID    INT NOT NULL,
  OldQuantity  INT NOT NULL,
  NewQuantity  INT NOT NULL,
  Reason       VARCHAR(200) NULL,
  AdjustedBy   INT NULL,
  AdjustedAt   DATETIME NOT NULL DEFAULT NOW(),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
) ENGINE=InnoDB;

-- ── Carts ─────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS Carts (
  CartID     INT AUTO_INCREMENT PRIMARY KEY,
  CustomerID INT NOT NULL UNIQUE,
  CreatedAt  DATETIME NOT NULL DEFAULT NOW(),
  UpdatedAt  DATETIME NULL,
  AbandonedEmailSent DATETIME NULL,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
) ENGINE=InnoDB;

-- ── CartItems ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS CartItems (
  CartItemID INT AUTO_INCREMENT PRIMARY KEY,
  CartID     INT NOT NULL,
  ProductID  INT NOT NULL,
  Quantity   INT NOT NULL DEFAULT 1,
  Price      DECIMAL(10,2) NOT NULL,
  AddedAt    DATETIME NOT NULL DEFAULT NOW(),
  UpdatedAt  DATETIME NULL,
  FOREIGN KEY (CartID)    REFERENCES Carts(CartID) ON DELETE CASCADE,
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
  UNIQUE KEY uq_cart_product (CartID, ProductID)
) ENGINE=InnoDB;

-- ── Discounts ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS Discounts (
  DiscountID          INT AUTO_INCREMENT PRIMARY KEY,
  Code                VARCHAR(50) NOT NULL UNIQUE,
  Description         VARCHAR(300),
  DiscountType        ENUM('percentage','fixed') NOT NULL,
  DiscountPercentage  DECIMAL(5,2) NULL,
  DiscountAmount      DECIMAL(10,2) NULL,
  MinOrderValue       DECIMAL(10,2) NOT NULL DEFAULT 0,
  MaxDiscountAmount   DECIMAL(10,2) NULL,
  UsageLimit          INT NULL,
  UsageCount          INT NOT NULL DEFAULT 0,
  StartDate           DATETIME NOT NULL,
  EndDate             DATETIME NOT NULL,
  ActiveStatus        TINYINT(1) NOT NULL DEFAULT 1,
  ShowPublicly        TINYINT(1) NOT NULL DEFAULT 0,
  ApplicableCategory  INT NULL,
  CreatedAt           DATETIME NOT NULL DEFAULT NOW(),
  UpdatedAt           DATETIME NULL
) ENGINE=InnoDB;

-- ── Orders ────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS Orders (
  OrderID              INT AUTO_INCREMENT PRIMARY KEY,
  CustomerID           INT NOT NULL,
  Status               ENUM('pending','confirmed','processing','shipped','delivered','cancelled','returned','refunded','on_hold') NOT NULL DEFAULT 'pending',
  SubTotal             DECIMAL(12,2) NOT NULL,
  TaxAmount            DECIMAL(10,2) NOT NULL DEFAULT 0,
  ShippingAmount       DECIMAL(10,2) NOT NULL DEFAULT 0,
  DiscountAmount       DECIMAL(10,2) NOT NULL DEFAULT 0,
  TotalAmount          DECIMAL(12,2) NOT NULL,
  Currency             VARCHAR(3) NOT NULL DEFAULT 'INR',
  PaymentMethod        VARCHAR(50) NOT NULL,
  ShippingAddress      TEXT NOT NULL,
  BillingAddress       TEXT NULL,
  CouponCode           VARCHAR(50) NULL,
  DiscountID           INT NULL,
  Notes                TEXT NULL,
  RefundStatus         VARCHAR(50) NULL,
  DeliveryDateEstimate DATE NULL,
  OrderDate            DATETIME NOT NULL DEFAULT NOW(),
  UpdatedAt            DATETIME NULL,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
  INDEX idx_customer (CustomerID),
  INDEX idx_status (Status),
  INDEX idx_date (OrderDate)
) ENGINE=InnoDB;

-- ── OrderItems ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS OrderItems (
  OrderItemID         INT AUTO_INCREMENT PRIMARY KEY,
  OrderID             INT NOT NULL,
  ProductID           INT NOT NULL,
  Quantity            INT NOT NULL,
  UnitPrice           DECIMAL(10,2) NOT NULL,
  MRP                 DECIMAL(10,2) NULL,
  DiscountApplied     DECIMAL(10,2) NOT NULL DEFAULT 0,
  LineTotal           DECIMAL(12,2) GENERATED ALWAYS AS (Quantity * UnitPrice) STORED,
  FulfillmentStatus   ENUM('pending','processing','picked','packed','shipped','delivered','returned','cancelled') NOT NULL DEFAULT 'pending',
  ReturnRequested     TINYINT(1) NOT NULL DEFAULT 0,
  FOREIGN KEY (OrderID)    REFERENCES Orders(OrderID),
  FOREIGN KEY (ProductID)  REFERENCES Products(ProductID)
) ENGINE=InnoDB;

-- ── OrderStatusHistory ────────────────────────────────────
CREATE TABLE IF NOT EXISTS OrderStatusHistory (
  HistoryID  INT AUTO_INCREMENT PRIMARY KEY,
  OrderID    INT NOT NULL,
  FromStatus VARCHAR(50) NULL,
  ToStatus   VARCHAR(50) NOT NULL,
  ChangedBy  VARCHAR(50) NULL,
  Note       TEXT NULL,
  ChangedAt  DATETIME NOT NULL DEFAULT NOW(),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
) ENGINE=InnoDB;

-- ── Payments ──────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS Payments (
  PaymentID            INT AUTO_INCREMENT PRIMARY KEY,
  OrderID              INT NOT NULL,
  Amount               DECIMAL(12,2) NOT NULL,
  Currency             VARCHAR(3) NOT NULL DEFAULT 'INR',
  PaymentMethod        VARCHAR(50) NOT NULL,
  PaymentStatus        ENUM('pending','initiated','completed','failed','refunded','partially_refunded','cancelled') NOT NULL DEFAULT 'pending',
  PaymentGateway       VARCHAR(20) NULL,
  GatewayOrderID       VARCHAR(100) NULL,
  GatewayPaymentID     VARCHAR(100) NULL,
  TransactionReference VARCHAR(200) NULL,
  GatewayResponse      TEXT NULL,
  PaymentDate          DATETIME NULL,
  CapturedAt           DATETIME NULL,
  AuthorizedAt         DATETIME NULL,
  RefundAmount         DECIMAL(10,2) NULL,
  RefundReference      VARCHAR(200) NULL,
  RefundDate           DATETIME NULL,
  FailureCode          VARCHAR(100) NULL,
  FailureReason        TEXT NULL,
  DeliveryNotes        TEXT NULL,
  CreatedAt            DATETIME NOT NULL DEFAULT NOW(),
  UpdatedAt            DATETIME NULL,
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
) ENGINE=InnoDB;

-- ── PaymentAttempts ───────────────────────────────────────
CREATE TABLE IF NOT EXISTS PaymentAttempts (
  AttemptID        INT AUTO_INCREMENT PRIMARY KEY,
  PaymentID        INT NOT NULL,
  OrderID          INT NOT NULL,
  GatewayOrderID   VARCHAR(100) NULL,
  GatewayPaymentID VARCHAR(100) NULL,
  PaymentMethod    VARCHAR(50) NULL,
  Status           VARCHAR(50) NOT NULL,
  Amount           DECIMAL(12,2) NULL,
  Currency         VARCHAR(3) NOT NULL DEFAULT 'INR',
  FailureCode      VARCHAR(100) NULL,
  FailureReason    TEXT NULL,
  IPAddress        VARCHAR(45) NULL,
  UserAgent        VARCHAR(200) NULL,
  AttemptedAt      DATETIME NOT NULL DEFAULT NOW(),
  FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID)
) ENGINE=InnoDB;

-- ── PaymentLinks ──────────────────────────────────────────
CREATE TABLE IF NOT EXISTS PaymentLinks (
  LinkID         INT AUTO_INCREMENT PRIMARY KEY,
  OrderID        INT NOT NULL,
  CustomerID     INT NOT NULL,
  GatewayLinkID  VARCHAR(100) NOT NULL,
  ShortURL       VARCHAR(300) NOT NULL,
  Amount         DECIMAL(12,2) NOT NULL,
  Status         ENUM('created','paid','expired','cancelled') NOT NULL DEFAULT 'created',
  ExpiresAt      DATETIME NULL,
  PaidAt         DATETIME NULL,
  CreatedAt      DATETIME NOT NULL DEFAULT NOW()
) ENGINE=InnoDB;

-- ── Shipping ──────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS Shipping (
  ShippingID            INT AUTO_INCREMENT PRIMARY KEY,
  OrderID               INT NOT NULL UNIQUE,
  Carrier               VARCHAR(100) NULL,
  TrackingNumber        VARCHAR(100) NULL,
  ShippingStatus        ENUM('pending','processing','shipped','out_for_delivery','delivered','returned','failed') NOT NULL DEFAULT 'pending',
  EstimatedDeliveryDate DATE NULL,
  ActualDeliveryDate    DATE NULL,
  DeliveryAttempts      INT NOT NULL DEFAULT 0,
  DeliveryNotes         TEXT NULL,
  ShippedAt             DATETIME NULL,
  CreatedAt             DATETIME NOT NULL DEFAULT NOW(),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
) ENGINE=InnoDB;

-- ── Reviews ───────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS Reviews (
  ReviewID          INT AUTO_INCREMENT PRIMARY KEY,
  ProductID         INT NOT NULL,
  CustomerID        INT NOT NULL,
  Rating            TINYINT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
  Title             VARCHAR(200) NULL,
  Comment           TEXT NULL,
  VerifiedPurchase  TINYINT(1) NOT NULL DEFAULT 0,
  HelpfulVotes      INT NOT NULL DEFAULT 0,
  ModerationStatus  ENUM('pending','approved','rejected','flagged') NOT NULL DEFAULT 'pending',
  Reply             TEXT NULL,
  ReplyDate         DATETIME NULL,
  ReviewDate        DATETIME NOT NULL DEFAULT NOW(),
  UpdatedAt         DATETIME NULL,
  FOREIGN KEY (ProductID)  REFERENCES Products(ProductID),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
  UNIQUE KEY uq_review (ProductID, CustomerID)
) ENGINE=InnoDB;

-- ── ReviewHelpfulVotes ────────────────────────────────────
CREATE TABLE IF NOT EXISTS ReviewHelpfulVotes (
  VoteID     INT AUTO_INCREMENT PRIMARY KEY,
  ReviewID   INT NOT NULL,
  CustomerID INT NOT NULL,
  VotedAt    DATETIME NOT NULL DEFAULT NOW(),
  FOREIGN KEY (ReviewID)   REFERENCES Reviews(ReviewID) ON DELETE CASCADE,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
  UNIQUE KEY uq_vote (ReviewID, CustomerID)
) ENGINE=InnoDB;

-- ── Wishlist ──────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS Wishlist (
  WishlistID INT AUTO_INCREMENT PRIMARY KEY,
  CustomerID INT NOT NULL,
  ProductID  INT NOT NULL,
  AddedAt    DATETIME NOT NULL DEFAULT NOW(),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
  FOREIGN KEY (ProductID)  REFERENCES Products(ProductID),
  UNIQUE KEY uq_wishlist (CustomerID, ProductID)
) ENGINE=InnoDB;

-- ── Affiliates ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS Affiliates (
  AffiliateID    INT AUTO_INCREMENT PRIMARY KEY,
  AffiliateName  VARCHAR(200) NOT NULL,
  Email          VARCHAR(255) NOT NULL UNIQUE,
  ReferralCode   VARCHAR(50) NOT NULL UNIQUE,
  CommissionRate DECIMAL(5,2) NOT NULL DEFAULT 5.00,
  TotalEarnings  DECIMAL(12,2) NOT NULL DEFAULT 0,
  TotalClicks    INT NOT NULL DEFAULT 0,
  Status         ENUM('active','inactive','suspended') NOT NULL DEFAULT 'active',
  CreatedAt      DATETIME NOT NULL DEFAULT NOW()
) ENGINE=InnoDB;

-- ── AffiliateConversions ──────────────────────────────────
CREATE TABLE IF NOT EXISTS AffiliateConversions (
  ConversionID      INT AUTO_INCREMENT PRIMARY KEY,
  AffiliateID       INT NOT NULL,
  OrderID           INT NOT NULL,
  CommissionEarned  DECIMAL(10,2) NOT NULL,
  ConvertedAt       DATETIME NOT NULL DEFAULT NOW(),
  FOREIGN KEY (AffiliateID) REFERENCES Affiliates(AffiliateID),
  UNIQUE KEY uq_conversion (AffiliateID, OrderID)
) ENGINE=InnoDB;

-- ── LoyaltyAdjustments ───────────────────────────────────
CREATE TABLE IF NOT EXISTS LoyaltyAdjustments (
  AdjustmentID INT AUTO_INCREMENT PRIMARY KEY,
  CustomerID   INT NOT NULL,
  Adjustment   INT NOT NULL,
  Reason       VARCHAR(300) NULL,
  AdjustedBy   VARCHAR(50) NULL,
  AdjustedAt   DATETIME NOT NULL DEFAULT NOW(),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
) ENGINE=InnoDB;

-- ── CustomerAddresses ─────────────────────────────────────
CREATE TABLE IF NOT EXISTS CustomerAddresses (
  AddressID   INT AUTO_INCREMENT PRIMARY KEY,
  CustomerID  INT NOT NULL,
  FullName    VARCHAR(200) NOT NULL,
  Phone       VARCHAR(20) NOT NULL,
  Line1       VARCHAR(300) NOT NULL,
  Line2       VARCHAR(300) NULL,
  City        VARCHAR(100) NOT NULL,
  State       VARCHAR(100) NOT NULL,
  PinCode     VARCHAR(20) NOT NULL,
  Country     VARCHAR(100) NOT NULL DEFAULT 'India',
  AddressType ENUM('home','work','other') NOT NULL DEFAULT 'home',
  IsDefault   TINYINT(1) NOT NULL DEFAULT 0,
  CreatedAt   DATETIME NOT NULL DEFAULT NOW(),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ── Seed categories ───────────────────────────────────────
INSERT IGNORE INTO Categories(CategoryID,CategoryName,IsActive) VALUES
  (1,'Electronics',1),(2,'Clothing',1),(3,'Books',1),(4,'Home Decor',1),
  (5,'Home Appliances',1),(6,'Gym Accessories',1),(7,'Sports',1),(8,'Medicines',1);

-- ── Default super_admin ───────────────────────────────────
-- Default password: Admin@123456!  (CHANGE THIS IMMEDIATELY)
INSERT IGNORE INTO AdminUsers(FirstName,LastName,Email,PasswordHash,Role)
VALUES('Admin','User','admin@deemona.com',
  '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewYpfQ8F2eHmSmP2','super_admin');
