CREATE TABLE "purchase"(
    "id" UUID NOT NULL,
    "customer_id" UUID NOT NULL,
    "product_id" UUID NOT NULL,
    "purchase_date" DATE NOT NULL,
    "purchase_value" DECIMAL(8, 2) NOT NULL,
    "coupon_used" BOOLEAN NOT NULL
);
CREATE INDEX "purchase_id_customer_id_product_id_index" ON
    "purchase"("id", "customer_id", "product_id");
ALTER TABLE
    "purchase" ADD PRIMARY KEY("id");
CREATE INDEX "purchase_customer_id_index" ON
    "purchase"("customer_id");
CREATE INDEX "purchase_product_id_index" ON
    "purchase"("product_id");
CREATE TABLE "product"(
    "id" UUID NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "category" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "value" DECIMAL(8, 2) NOT NULL,
    "on_offer" BOOLEAN NOT NULL,
    "offer_percent" DECIMAL(8, 2) NULL
);
CREATE INDEX "product_id_index" ON
    "product"("id");
ALTER TABLE
    "product" ADD PRIMARY KEY("id");
CREATE TABLE "customer"(
    "id" UUID NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "birthday" DATE NOT NULL,
    "country" VARCHAR(255) NOT NULL,
    "state" VARCHAR(255) NOT NULL
);
CREATE INDEX "customer_id_index" ON
    "customer"("id");
ALTER TABLE
    "customer" ADD PRIMARY KEY("id");
ALTER TABLE
    "purchase" ADD CONSTRAINT "purchase_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "product"("id");
ALTER TABLE
    "purchase" ADD CONSTRAINT "purchase_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "customer"("id");