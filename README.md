# README

## Dependencies

- Ruby v3.1.2
- SQLite3 v3.31.1

## Deployment

1. `bin/bundle install`
2. `bin/rails db:setup RAILS_ENV=development`
3. `bin/rails server -b 0.0.0.0 -p 3000 -e development`
4. Navigate to `http://localhost:3000/` and see the Rails default splash page

## Documentation

There are 4 models:

- `Merchant`
    - Represents registered merchants
    - These are created manually
    - The DB should be seeded with 3 of these models after running `bin/rails db:setup RAILS_ENV=development`
- `CcTransaction`
    - Represents credit card transactions
    - These are created manually or via API calls
- `AchTransaction`
    - Represents bank account transactions
    - These are created manually or via API calls
- `Payout`
    - Stores payout information for a particular merchant on a particular billing date
    - These are created and updated automatically, as `CcTransaction` or `AchTransaction` records are created via API
      calls

### API Endpoints
#### Merchants
- `GET /merchants`
    - Shows all currently saved `Merchant` records
#### CcTransactions
- `GET /cc_transactions`
    - Shows all currently saved `CcTransaction` records
- `POST /cc_transactions`
    - Accepts a JSON body of the following shape:
        - ```json
          {
            "cc_transaction": {
              "card_number": "4242424242424242",
              "expiry_year": "2022",
              "expiry_month": "01",
              "cvv": "123",
              "billing_date": "2022-05-08",
              "zip": "12345",
              "amount": 22.22,
              "merchant_id": 2
            }
          }
          ```
- `GET /cc_transactions/:id`
  - Shows details of `CcTransaction` with id of `:id`
#### AchTransactions
- `GET /ach_transactions`
    - Shows all currently saved `AchTransaction` records
- `POST /ach_transactions`
    - Accepts a JSON body of the following shape:
        - ```json
          {
            "ach_transaction": {
              "account_number": "1234567890",
              "routing_number": "121042882",
              "billing_date": "2022-05-08",
              "amount": 2.22,
              "merchant_id": 2
            }
          }
          ```
- `GET /ach_transactions/:id`
    - Shows details of `AchTransaction` with id of `:id`

#### Payouts and Audits
- `GET /audits/transactions?billing_date=:billing_date`
  - `:billing_date` is in the format of `YYYY-MM-DD`
  - Returns a JSON response with all transactions grouped by merchant name
- `GET /audits/payouts`
  - Shows all current `Payout` records without associated transactions
- `GET /audits/payout/:id`
  - Shows details of `Payout` record with associated transactions
