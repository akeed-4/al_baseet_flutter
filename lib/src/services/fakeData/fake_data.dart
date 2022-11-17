class FakeData {
  static var products = {
    "data": [
      {
        "product_data": {
          "product_id": "A1",
          "product_name": {"ar": "بيبسي", "en": "Pepsi"},
          "product_image": null,
          "product_description": null,
          "available_quantity": 10.0
        },
      },
      {
        "product_data": {
          "product_id": "A2",
          "product_name": {"ar": "ميرندا", "en": "Merinda"},
          "product_image": null,
          "product_description": null,
          "available_quantity": 15.0
        },
      }
    ]
  };

  static var historyData = {
    "data": [
      {
        "product_data": {
          "product_id": "A1",
          "product_name": {"ar": "بيبسي", "en": "Pepsi"},
          "product_image": null,
          "product_description": null,
          "available_quantity": -4.0,
          "price": 100.0
        },
        "invoice": {
          "id": 1,
          "invoice_no": 1.0,
          "invoice_type": null,
          "invoice_date": "2021-08-23T00:00:00",
          "total_amount": 0.0,
          "paid_amount": 0.0,
          "invoice_acceptance": 1,
          "customer": {
            "customer_id": 1,
            "customer_name": {"ar": "محمد", "en": null},
            "customer_image": null,
            "customer_address": null,
            "invoices_count": 4,
            "receipts_amount": 0.0
          },
          "products": [
            {
              "product_data": {
                "product_id": "A1",
                "product_name": {"ar": "بيبسي", "en": "Pepsi"},
                "product_image": null,
                "product_description": null,
                "available_quantity": -4.0,
                "price": 100.0
              },
              "quantity": 10.0,
              "price": 100.0
            }
          ],
          "receipts": []
        },
        "quantity": 10.0
      },
      {
        "product_data": {
          "product_id": "A1",
          "product_name": {"ar": "بيبسي", "en": "Pepsi"},
          "product_image": null,
          "product_description": null,
          "available_quantity": -4.0,
          "price": 100.0
        },
        "invoice": {
          "id": 16,
          "invoice_no": 78.0,
          "invoice_type": "002",
          "invoice_date": "2021-09-22T02:23:56.051817",
          "total_amount": 2.7,
          "paid_amount": 2.7,
          "invoice_acceptance": 1,
          "customer": {
            "customer_id": 2,
            "customer_name": {"ar": "خالد", "en": null},
            "customer_image": null,
            "customer_address": null,
            "invoices_count": 6,
            "receipts_amount": 552.7
          },
          "products": [
            {
              "product_data": {
                "product_id": "A1",
                "product_name": {"ar": "بيبسي", "en": "Pepsi"},
                "product_image": null,
                "product_description": null,
                "available_quantity": -4.0,
                "price": 100.0
              },
              "quantity": 1.0,
              "price": 1.0
            }
          ],
          "receipts": []
        },
        "quantity": -1.0
      },
      {
        "product_data": {
          "product_id": "A1",
          "product_name": {"ar": "بيبسي", "en": "Pepsi"},
          "product_image": null,
          "product_description": null,
          "available_quantity": -4.0,
          "price": 100.0
        },
        "invoice": {
          "id": 17,
          "invoice_no": 45.0,
          "invoice_type": "001",
          "invoice_date": "2022-12-01T00:00:00",
          "total_amount": 9.8,
          "paid_amount": 9.8,
          "invoice_acceptance": 1,
          "customer": {
            "customer_id": 2,
            "customer_name": {"ar": "خالد", "en": null},
            "customer_image": null,
            "customer_address": null,
            "invoices_count": 6,
            "receipts_amount": 552.7
          },
          "products": [
            {
              "product_data": {
                "product_id": "A1",
                "product_name": {"ar": "بيبسي", "en": "Pepsi"},
                "product_image": null,
                "product_description": null,
                "available_quantity": -4.0,
                "price": 100.0
              },
              "quantity": 3.0,
              "price": 1.0
            }
          ],
          "receipts": []
        },
        "quantity": -3.0
      },
      {
        "product_data": {
          "product_id": "A1",
          "product_name": {"ar": "بيبسي", "en": "Pepsi"},
          "product_image": null,
          "product_description": null,
          "available_quantity": -4.0,
          "price": 100.0
        },
        "invoice": {
          "id": 22,
          "invoice_no": 11.0,
          "invoice_type": null,
          "invoice_date": "2020-01-03T00:00:00",
          "total_amount": 0.0,
          "paid_amount": 0.0,
          "invoice_acceptance": 1,
          "customer": {
            "customer_id": 1,
            "customer_name": {"ar": "محمد", "en": null},
            "customer_image": null,
            "customer_address": null,
            "invoices_count": 4,
            "receipts_amount": 0.0
          },
          "products": [
            {
              "product_data": {
                "product_id": "A1",
                "product_name": {"ar": "بيبسي", "en": "Pepsi"},
                "product_image": null,
                "product_description": null,
                "available_quantity": -4.0,
                "price": 100.0
              },
              "quantity": 3.0,
              "price": 19.0
            }
          ],
          "receipts": []
        },
        "quantity": 3.0
      },
      {
        "product_data": {
          "product_id": "A1",
          "product_name": {"ar": "بيبسي", "en": "Pepsi"},
          "product_image": null,
          "product_description": null,
          "available_quantity": -4.0,
          "price": 100.0
        },
        "invoice": {
          "id": 1017,
          "invoice_no": null,
          "invoice_type": "002",
          "invoice_date": "2020-01-01T00:00:00",
          "total_amount": 0.0,
          "paid_amount": 0.0,
          "invoice_acceptance": 1,
          "customer": {
            "customer_id": 1,
            "customer_name": {"ar": "محمد", "en": null},
            "customer_image": null,
            "customer_address": null,
            "invoices_count": 4,
            "receipts_amount": 0.0
          },
          "products": [
            {
              "product_data": {
                "product_id": "A1",
                "product_name": {"ar": "بيبسي", "en": "Pepsi"},
                "product_image": null,
                "product_description": null,
                "available_quantity": -4.0,
                "price": 100.0
              },
              "quantity": 5.0,
              "price": null
            }
          ],
          "receipts": []
        },
        "quantity": -5.0
      },
      {
        "product_data": {
          "product_id": "A1",
          "product_name": {"ar": "بيبسي", "en": "Pepsi"},
          "product_image": null,
          "product_description": null,
          "available_quantity": -4.0,
          "price": 100.0
        },
        "invoice": {
          "id": 1019,
          "invoice_no": 1.0,
          "invoice_type": null,
          "invoice_date": "2021-09-21T14:46:20.6588032",
          "total_amount": 0.0,
          "paid_amount": 0.0,
          "invoice_acceptance": 1,
          "customer": {
            "customer_id": 0,
            "customer_name": null,
            "customer_image": null,
            "customer_address": null,
            "invoices_count": 0,
            "receipts_amount": 0.0
          },
          "products": [
            {
              "product_data": {
                "product_id": "A1",
                "product_name": {"ar": "بيبسي", "en": "Pepsi"},
                "product_image": null,
                "product_description": null,
                "available_quantity": -4.0,
                "price": 100.0
              },
              "quantity": 5.0,
              "price": 0.0
            }
          ],
          "receipts": []
        },
        "quantity": -5.0
      },
      {
        "product_data": {
          "product_id": "A1",
          "product_name": {"ar": "بيبسي", "en": "Pepsi"},
          "product_image": null,
          "product_description": null,
          "available_quantity": -4.0,
          "price": 100.0
        },
        "invoice": {
          "id": 1020,
          "invoice_no": 2.0,
          "invoice_type": null,
          "invoice_date": "2021-09-21T14:50:54.0587889",
          "total_amount": 0.0,
          "paid_amount": 0.0,
          "invoice_acceptance": 1,
          "customer": {
            "customer_id": 0,
            "customer_name": null,
            "customer_image": null,
            "customer_address": null,
            "invoices_count": 0,
            "receipts_amount": 0.0
          },
          "products": [
            {
              "product_data": {
                "product_id": "A1",
                "product_name": {"ar": "بيبسي", "en": "Pepsi"},
                "product_image": null,
                "product_description": null,
                "available_quantity": -4.0,
                "price": 100.0
              },
              "quantity": 1.0,
              "price": 0.0
            }
          ],
          "receipts": []
        },
        "quantity": -1.0
      },
      {
        "product_data": {
          "product_id": "A1",
          "product_name": {"ar": "بيبسي", "en": "Pepsi"},
          "product_image": null,
          "product_description": null,
          "available_quantity": -4.0,
          "price": 100.0
        },
        "invoice": {
          "id": 1023,
          "invoice_no": 99.0,
          "invoice_type": "003",
          "invoice_date": "2022-11-01T00:00:00",
          "total_amount": 1.0,
          "paid_amount": 1.0,
          "invoice_acceptance": 1,
          "customer": {
            "customer_id": 2,
            "customer_name": {"ar": "خالد", "en": null},
            "customer_image": null,
            "customer_address": null,
            "invoices_count": 6,
            "receipts_amount": 552.7
          },
          "products": [
            {
              "product_data": {
                "product_id": "A1",
                "product_name": {"ar": "بيبسي", "en": "Pepsi"},
                "product_image": null,
                "product_description": null,
                "available_quantity": -4.0,
                "price": 100.0
              },
              "quantity": 1.0,
              "price": 1.0
            }
          ],
          "receipts": []
        },
        "quantity": 1.0
      },
      {
        "product_data": {
          "product_id": "A1",
          "product_name": {"ar": "بيبسي", "en": "Pepsi"},
          "product_image": null,
          "product_description": null,
          "available_quantity": -4.0,
          "price": 100.0
        },
        "invoice": {
          "id": 1024,
          "invoice_no": 199.0,
          "invoice_type": "003",
          "invoice_date": "2022-11-01T00:00:00",
          "total_amount": 1.0,
          "paid_amount": 1.0,
          "invoice_acceptance": 1,
          "customer": {
            "customer_id": 2,
            "customer_name": {"ar": "خالد", "en": null},
            "customer_image": null,
            "customer_address": null,
            "invoices_count": 6,
            "receipts_amount": 552.7
          },
          "products": [
            {
              "product_data": {
                "product_id": "A1",
                "product_name": {"ar": "بيبسي", "en": "Pepsi"},
                "product_image": null,
                "product_description": null,
                "available_quantity": -4.0,
                "price": 100.0
              },
              "quantity": 1.0,
              "price": 1.0
            }
          ],
          "receipts": []
        },
        "quantity": 1.0
      },
      {
        "product_data": {
          "product_id": "A1",
          "product_name": {"ar": "بيبسي", "en": "Pepsi"},
          "product_image": null,
          "product_description": null,
          "available_quantity": -4.0,
          "price": 100.0
        },
        "invoice": {
          "id": 1026,
          "invoice_no": 78.0,
          "invoice_type": "002",
          "invoice_date": "2021-09-22T03:15:54.432697",
          "total_amount": 163.0,
          "paid_amount": 163.0,
          "invoice_acceptance": 1,
          "customer": {
            "customer_id": 3,
            "customer_name": {"ar": "Ahmed", "en": null},
            "customer_image": null,
            "customer_address": null,
            "invoices_count": 2,
            "receipts_amount": 0.0
          },
          "products": [
            {
              "product_data": {
                "product_id": "A1",
                "product_name": {"ar": "بيبسي", "en": "Pepsi"},
                "product_image": null,
                "product_description": null,
                "available_quantity": -4.0,
                "price": 100.0
              },
              "quantity": 1.0,
              "price": 100.0
            }
          ],
          "receipts": []
        },
        "quantity": -1.0
      },
      {
        "product_data": {
          "product_id": "A1",
          "product_name": {"ar": "بيبسي", "en": "Pepsi"},
          "product_image": null,
          "product_description": null,
          "available_quantity": -4.0,
          "price": 100.0
        },
        "invoice": {
          "id": 1035,
          "invoice_no": 54.0,
          "invoice_type": "003",
          "invoice_date": "2022-11-01T00:00:00",
          "total_amount": 1.0,
          "paid_amount": 1.0,
          "invoice_acceptance": 1,
          "customer": {
            "customer_id": 2,
            "customer_name": {"ar": "خالد", "en": null},
            "customer_image": null,
            "customer_address": null,
            "invoices_count": 6,
            "receipts_amount": 552.7
          },
          "products": [
            {
              "product_data": {
                "product_id": "A1",
                "product_name": {"ar": "بيبسي", "en": "Pepsi"},
                "product_image": null,
                "product_description": null,
                "available_quantity": -4.0,
                "price": 100.0
              },
              "quantity": 1.0,
              "price": 1.0
            }
          ],
          "receipts": []
        },
        "quantity": 1.0
      },
      {
        "product_data": {
          "product_id": "A1",
          "product_name": {"ar": "بيبسي", "en": "Pepsi"},
          "product_image": null,
          "product_description": null,
          "available_quantity": -4.0,
          "price": 100.0
        },
        "invoice": {
          "id": 1036,
          "invoice_no": 4.0,
          "invoice_type": null,
          "invoice_date": "2021-09-23T12:19:18.5925668",
          "total_amount": 0.0,
          "paid_amount": 0.0,
          "invoice_acceptance": 1,
          "customer": {
            "customer_id": 0,
            "customer_name": null,
            "customer_image": null,
            "customer_address": null,
            "invoices_count": 0,
            "receipts_amount": 0.0
          },
          "products": [
            {
              "product_data": {
                "product_id": "A1",
                "product_name": {"ar": "بيبسي", "en": "Pepsi"},
                "product_image": null,
                "product_description": null,
                "available_quantity": -4.0,
                "price": 100.0
              },
              "quantity": 1.0,
              "price": 0.0
            }
          ],
          "receipts": []
        },
        "quantity": -1.0
      },
      {
        "product_data": {
          "product_id": "A1",
          "product_name": {"ar": "بيبسي", "en": "Pepsi"},
          "product_image": null,
          "product_description": null,
          "available_quantity": -4.0,
          "price": 100.0
        },
        "invoice": {
          "id": 1037,
          "invoice_no": 5.0,
          "invoice_type": null,
          "invoice_date": "2021-09-26T01:38:39.4780835",
          "total_amount": 0.0,
          "paid_amount": 0.0,
          "invoice_acceptance": 1,
          "customer": {
            "customer_id": 0,
            "customer_name": null,
            "customer_image": null,
            "customer_address": null,
            "invoices_count": 0,
            "receipts_amount": 0.0
          },
          "products": [
            {
              "product_data": {
                "product_id": "A1",
                "product_name": {"ar": "بيبسي", "en": "Pepsi"},
                "product_image": null,
                "product_description": null,
                "available_quantity": -4.0,
                "price": 100.0
              },
              "quantity": 1.0,
              "price": 0.0
            }
          ],
          "receipts": []
        },
        "quantity": -1.0
      },
      {
        "product_data": {
          "product_id": "A1",
          "product_name": {"ar": "بيبسي", "en": "Pepsi"},
          "product_image": null,
          "product_description": null,
          "available_quantity": -4.0,
          "price": 100.0
        },
        "invoice": {
          "id": 1038,
          "invoice_no": 6.0,
          "invoice_type": null,
          "invoice_date": "2021-09-26T02:10:35.832473",
          "total_amount": 0.0,
          "paid_amount": 0.0,
          "invoice_acceptance": 1,
          "customer": {
            "customer_id": 0,
            "customer_name": null,
            "customer_image": null,
            "customer_address": null,
            "invoices_count": 0,
            "receipts_amount": 0.0
          },
          "products": [
            {
              "product_data": {
                "product_id": "A1",
                "product_name": {"ar": "بيبسي", "en": "Pepsi"},
                "product_image": null,
                "product_description": null,
                "available_quantity": -4.0,
                "price": 100.0
              },
              "quantity": 2.0,
              "price": 0.0
            }
          ],
          "receipts": []
        },
        "quantity": -2.0
      }
    ],
    "status": true,
    "message": "success",
    "error_code": 100
  };

  static var invoices = {
    "data": [
      {
        "id": 1115,
        "invoice_no": 5.0,
        "invoice_type": 002,
        "invoice_date": "2021-11-07T16:47:20.257707",
        "total_amount": 244.0,
        "paid_amount": 0.0,
        "invoice_acceptance": 0,
        "customer": {
          "customer_id": 10,
          "customer_name": {"ar": "امير", "en": null},
          "customer_image": null,
          "customer_address": null,
          "invoices_count": 0,
          "receipts_amount": 0.0
        },
        products: [
          {
            "product_data": {
              "product_id": "A1",
              "product_name": {"ar": "بيبسي", "en": "Pepsi"},
              "product_image": null,
              "product_description": null,
              "available_quantity": 12.0,
              "price": 100.0
            },
            "quantity": 2.0,
            "price": 100.0
          },
          {
            "product_data": {
              "product_id": "A2",
              "product_name": {"ar": "سيفن اب", "en": "7up"},
              "product_image": null,
              "product_description": null,
              "available_quantity": 100.0,
              "price": 22.0
            },
            "quantity": 2.0,
            "price": 22.0
          }
        ],
        "receipts": []
      }
    ]
  };
}
