CREATE TABLE products (


  field_name integer REFERENCES table_name (field_name) ON {DELETE|UPDATE} {RESTRICT|CASCADE|NO ACTION|SET NULL|SET DEFAULT},
  -- или
  FOREIGN KEY (b, c) REFERENCES other_table (c1, c2),


  product_no integer PRIMARY KEY,
  name text,
  price numeric
);

CREATE TABLE orders (
  order_id integer PRIMARY KEY,
  product_no integer REFERENCES products (product_no),
  -- или
  product_no integer REFERENCES products,
  quantity integer
  -- или
  FOREIGN KEY (b, c) REFERENCES other_table (c1, c2)
);

-- Много ко многим
CREATE TABLE products (
  product_no integer PRIMARY KEY,
  name text,
  price numeric
);
CREATE TABLE orders (
  order_id integer PRIMARY KEY,
  shipping_address text,
  ...
);
CREATE TABLE order_items (
  product_no integer REFERENCES products ON DELETE RESTRICT,
  order_id integer REFERENCES orders ON DELETE CASCADE,
  quantity integer,
  PRIMARY KEY (product_no, order_id)
);
