BEGIN TRANSACTION;
CREATE TABLE "GoodsType"
(
    "TID"   INTEGER NOT NULL UNIQUE,
    "TName" INTEGER NOT NULL UNIQUE,
    PRIMARY KEY ("TID" AUTOINCREMENT)
);
CREATE TABLE "Goods"
(
    "GID"    INTEGER NOT NULL UNIQUE,
    "GName"  TEXT    NOT NULL UNIQUE,
    "GPrice" NUMERIC NOT NULL,
    "TID"    INTEGER,
    FOREIGN KEY ("TID") REFERENCES "GoodsType" ("TID") ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY ("GID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "RedeemGoods"
(
    "GID"      INTEGER NOT NULL,
    "RGCredit" INTEGER NOT NULL DEFAULT 0 CHECK ("RGCredit" >= 0),
    FOREIGN KEY ("GID") REFERENCES "Goods" ("GID") ON UPDATE CASCADE ON DELETE NO ACTION,
    PRIMARY KEY ("GID")
);
CREATE TABLE IF NOT EXISTS "Redeem"
(
    "RID"     INTEGER NOT NULL UNIQUE,
    "CID"     INTEGER NOT NULL,
    "GID"     INTEGER NOT NULL,
    "RAmount" INTEGER NOT NULL CHECK ("RAmount" > 0),
    "RCredit" INTEGER NOT NULL,
    FOREIGN KEY ("CID") REFERENCES "Customer" ("CID") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("GID") REFERENCES "Goods" ("GID") ON DELETE NO ACTION ON UPDATE CASCADE,
    PRIMARY KEY ("RID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "DiscountedGoods"
(
    "GID"           INTEGER NOT NULL UNIQUE,
    "DGPrice"       NUMERIC NOT NULL,
    "DGExpiredDate" TEXT    NOT NULL,
    FOREIGN KEY ("GID") REFERENCES "Goods" ("GID") ON DELETE NO ACTION ON UPDATE CASCADE,
    PRIMARY KEY ("GID")
);
CREATE TABLE IF NOT EXISTS "Admin"
(
    "ID"       INTEGER NOT NULL UNIQUE,
    "Login"    TEXT    NOT NULL UNIQUE,
    "Password" TEXT    NOT NULL,
    "Level"    INTEGER NOT NULL DEFAULT 1 CHECK ("Level" > 0),
    PRIMARY KEY ("ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Discount"
(
    "CLevel"   INTEGER NOT NULL UNIQUE,
    "Discount" NUMERIC NOT NULL,
    "Floor"    NUMERIC NOT NULL,
    "Ceiling"  NUMERIC NOT NULL,
    PRIMARY KEY ("CLevel")
);
CREATE TABLE IF NOT EXISTS "Customer"
(
    "CID"       INTEGER NOT NULL UNIQUE,
    "CLogin"    TEXT    NOT NULL UNIQUE,
    "CPassword" TEXT    NOT NULL,
    "CPhone"    INTEGER NOT NULL UNIQUE,
    "CBirthday" TEXT    NOT NULL,
    "CWork"     INTEGER NOT NULL,
    "CCredit"   NUMERIC NOT NULL DEFAULT 0,
    "CLevel"    INTEGER NOT NULL DEFAULT 0,
    "CRegDate"  TEXT    NOT NULL DEFAULT '2021-01-01',
    "CName"     TEXT    NOT NULL,
    "CSum"      NUMERIC NOT NULL DEFAULT 0,
    FOREIGN KEY ("CLevel") REFERENCES "Discount" ("CLevel") ON DELETE NO ACTION ON UPDATE CASCADE,
    PRIMARY KEY ("CID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Purchase"
(
    "PNo"     INTEGER NOT NULL UNIQUE,
    "CID"     INTEGER,
    "GID"     INTEGER NOT NULL,
    "PAmount" INTEGER NOT NULL CHECK ("PAmount" > 0),
    "PTime"   TEXT    NOT NULL,
    "PMoney"  NUMERIC NOT NULL,
    FOREIGN KEY ("CID") REFERENCES "Customer" ("CID") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("GID") REFERENCES "Goods" ("GID") ON UPDATE CASCADE ON DELETE NO ACTION,
    PRIMARY KEY ("PNo" AUTOINCREMENT)
);
INSERT INTO Admin (Login, Password, Level)
VALUES ('Admin', 'Admin', 3);
INSERT INTO Discount (CLevel, Discount, Floor, Ceiling)
VALUES (0, 1, 0, 100);
COMMIT;
