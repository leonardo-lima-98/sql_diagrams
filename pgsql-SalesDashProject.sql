CREATE TABLE "sales"(
    "id" UUID NOT NULL,
    "costumer_id" UUID NOT NULL,
    "costumer_name" VARCHAR(255) NOT NULL,
    "birthday" DATE NOT NULL,
    "country" VARCHAR(255) NOT NULL,
    "state" VARCHAR(255) NOT NULL,
    "purchase_id" UUID NOT NULL,
    "purchase_date" DATE NOT NULL,
    "purchase_value" DECIMAL(8, 2) NOT NULL,
    "coupon_used" BOOLEAN NOT NULL
);
ALTER TABLE
    "sales" ADD PRIMARY KEY("id");
CREATE INDEX "sales_costumer_id_index" ON
    "sales"("costumer_id");
CREATE INDEX "sales_purchase_id_index" ON
    "sales"("purchase_id");
CREATE TABLE "purchase"(
    "id" UUID NOT NULL,
    "item_id" UUID NOT NULL,
    "item_name" VARCHAR(255) NOT NULL,
    "item_value" DECIMAL(8, 2) NOT NULL,
    "on_offer" BOOLEAN NOT NULL,
    "offer_percent" DECIMAL(8, 2) NULL
);
ALTER TABLE
    "purchase" ADD PRIMARY KEY("id");
CREATE INDEX "purchase_item_id_index" ON
    "purchase"("item_id");
ALTER TABLE
    "sales" ADD CONSTRAINT "sales_purchase_id_foreign" FOREIGN KEY("purchase_id") REFERENCES "purchase"("id");