```mermaid
sequenceDiagram
    participant User
    participant OrderService
    participant PaymentService
    participant ShipmentService
    participant ReviewService
    participant DB

    User->>OrderService: Place Order
    OrderService->>DB: Create entry in orders, order_items
    OrderService-->>User: Order Confirmation

    User->>PaymentService: Make Payment
    PaymentService->>DB: Record payment details in payments
    PaymentService-->>User: Payment Success

    User->>ShipmentService: Check Shipment Status
    ShipmentService->>DB: Retrieve shipment details from shipments
    ShipmentService-->>User: Shipment Tracking Information

    User->>ReviewService: Submit Product Review
    ReviewService->>DB: Add review to reviews
    ReviewService-->>User: Review Submitted
