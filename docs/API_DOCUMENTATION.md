# API Documentation

This document provides comprehensive API endpoint documentation for the e-commerce system tested by the Karate framework.

**Author**: Divya.V, II MSc Computer Science, Gobi Arts and Science College (Autonomous), Gobichettipalayam, Erode District, Pin 638458

## 📋 Table of Contents

1. [Authentication Endpoints](#authentication-endpoints)
2. [Product Catalog Endpoints](#product-catalog-endpoints)
3. [Shopping Cart Endpoints](#shopping-cart-endpoints)
4. [Checkout & Order Endpoints](#checkout--order-endpoints)
5. [Error Responses](#error-responses)
6. [Rate Limiting](#rate-limiting)
7. [Authentication](#authentication-1)

## 🔐 Authentication Endpoints

### User Login

**Endpoint**: `POST /auth/login`

**Description**: Authenticate user and receive access token

**Request Body**:
```json
{
  "username": "john_doe",
  "password": "password123"
}
```

**Response**:
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "expiresIn": 3600,
  "refreshToken": "refresh_token_here"
}
```

**Status Codes**:
- `200`: Success
- `401`: Invalid credentials
- `400`: Missing required fields

### User Registration

**Endpoint**: `POST /users`

**Description**: Register a new user account

**Request Body**:
```json
{
  "username": "newuser123",
  "email": "user@example.com",
  "password": "SecurePass123!",
  "firstName": "John",
  "lastName": "Doe",
  "phone": "1234567890"
}
```

**Response**:
```json
{
  "id": 123,
  "username": "newuser123",
  "email": "user@example.com",
  "message": "User registered successfully"
}
```

**Status Codes**:
- `201`: User created successfully
- `400`: Validation error
- `409`: Username or email already exists

### Token Refresh

**Endpoint**: `POST /auth/refresh`

**Description**: Refresh access token using refresh token

**Request Body**:
```json
{
  "refreshToken": "refresh_token_here"
}
```

**Response**:
```json
{
  "token": "new_access_token",
  "expiresIn": 3600,
  "refreshToken": "new_refresh_token"
}
```

### User Profile

**Endpoint**: `GET /users/1`

**Description**: Get user profile information

**Headers**: `Authorization: Bearer <token>`

**Response**:
```json
{
  "id": 1,
  "username": "john_doe",
  "email": "john@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "phone": "1234567890",
  "createdAt": "2024-01-01T00:00:00Z"
}
```

## 🛍️ Product Catalog Endpoints

### Get All Products

**Endpoint**: `GET /products`

**Description**: Retrieve list of all products with pagination

**Query Parameters**:
- `page`: Page number (default: 1)
- `limit`: Items per page (default: 10)
- `sort`: Sort field (price, name, rating)
- `order`: Sort order (asc, desc)

**Response**:
```json
{
  "products": [
    {
      "id": 1,
      "title": "Product Name",
      "price": 99.99,
      "category": "electronics",
      "description": "Product description",
      "image": "https://example.com/image.jpg",
      "rating": {
        "rate": 4.5,
        "count": 120
      }
    }
  ],
  "metadata": {
    "page": 1,
    "limit": 10,
    "total": 100,
    "totalPages": 10,
    "hasNext": true,
    "hasPrev": false
  }
}
```

### Search Products

**Endpoint**: `GET /products/search`

**Description**: Search products by keyword

**Query Parameters**:
- `q`: Search query
- `category`: Filter by category
- `minPrice`: Minimum price filter
- `maxPrice`: Maximum price filter

**Response**:
```json
{
  "products": [
    {
      "id": 1,
      "title": "Laptop Pro",
      "price": 999.99,
      "category": "electronics",
      "description": "High-performance laptop",
      "image": "https://example.com/laptop.jpg"
    }
  ],
  "searchMetadata": {
    "query": "laptop",
    "totalResults": 25,
    "searchTime": 0.05
  }
}
```

### Get Product Details

**Endpoint**: `GET /products/{id}`

**Description**: Get detailed information for a specific product

**Response**:
```json
{
  "id": 1,
  "title": "Product Name",
  "price": 99.99,
  "category": "electronics",
  "description": "Detailed product description",
  "image": "https://example.com/image.jpg",
  "images": [
    "https://example.com/image1.jpg",
    "https://example.com/image2.jpg"
  ],
  "specifications": {
    "brand": "Brand Name",
    "model": "Model X",
    "warranty": "2 years"
  },
  "rating": {
    "rate": 4.5,
    "count": 120
  },
  "inventory": {
    "quantity": 50,
    "inStock": true,
    "lowStockThreshold": 10
  }
}
```

### Get Product Categories

**Endpoint**: `GET /products/categories`

**Description**: Get list of all product categories

**Response**:
```json
[
  "electronics",
  "clothing",
  "books",
  "home",
  "sports",
  "toys"
]
```

### Create Product (Admin)

**Endpoint**: `POST /products`

**Description**: Create a new product (admin only)

**Headers**: `Authorization: Bearer <admin_token>`

**Request Body**:
```json
{
  "title": "New Product",
  "price": 149.99,
  "category": "electronics",
  "description": "Product description",
  "image": "https://example.com/image.jpg",
  "specifications": {
    "brand": "Brand",
    "model": "Model"
  }
}
```

**Response**:
```json
{
  "id": 101,
  "title": "New Product",
  "price": 149.99,
  "category": "electronics",
  "message": "Product created successfully"
}
```

## 🛒 Shopping Cart Endpoints

### Get User Cart

**Endpoint**: `GET /carts/1`

**Description**: Get current user's shopping cart

**Headers**: `Authorization: Bearer <token>`

**Response**:
```json
{
  "cartId": 123,
  "userId": 1,
  "items": [
    {
      "id": 456,
      "productId": 1,
      "quantity": 2,
      "price": 99.99,
      "totalPrice": 199.98,
      "addedAt": "2024-01-01T10:00:00Z",
      "product": {
        "title": "Product Name",
        "image": "https://example.com/image.jpg"
      }
    }
  ],
  "totalAmount": 199.98,
  "itemCount": 2,
  "lastUpdated": "2024-01-01T10:00:00Z"
}
```

### Add Item to Cart

**Endpoint**: `POST /carts`

**Description**: Add item to shopping cart

**Headers**: `Authorization: Bearer <token>`

**Request Body**:
```json
{
  "productId": 1,
  "quantity": 2,
  "price": 99.99
}
```

**Response**:
```json
{
  "cartId": 123,
  "items": [
    {
      "id": 456,
      "productId": 1,
      "quantity": 2,
      "price": 99.99,
      "totalPrice": 199.98
    }
  ],
  "totalAmount": 199.98,
  "itemCount": 2,
  "message": "Item added to cart successfully"
}
```

### Update Cart Item

**Endpoint**: `PUT /carts/1/items/{itemId}`

**Description**: Update quantity of cart item

**Headers**: `Authorization: Bearer <token>`

**Request Body**:
```json
{
  "quantity": 3
}
```

**Response**:
```json
{
  "cartId": 123,
  "itemId": 456,
  "quantity": 3,
  "totalPrice": 299.97,
  "message": "Cart item updated successfully"
}
```

### Remove Cart Item

**Endpoint**: `DELETE /carts/1/items/{itemId}`

**Description**: Remove item from shopping cart

**Headers**: `Authorization: Bearer <token>`

**Response**:
```json
{
  "message": "Item removed from cart successfully",
  "cartId": 123,
  "remainingItems": 2
}
```

### Clear Cart

**Endpoint**: `DELETE /carts/1`

**Description**: Clear entire shopping cart

**Headers**: `Authorization: Bearer <token>`

**Response**:
```json
{
  "message": "Cart cleared successfully",
  "cartId": 123,
  "itemsRemoved": 3
}
```

### Apply Discount

**Endpoint**: `PUT /carts/1/discount`

**Description**: Apply discount code to cart

**Headers**: `Authorization: Bearer <token>`

**Request Body**:
```json
{
  "discountCode": "SAVE20"
}
```

**Response**:
```json
{
  "cartId": 123,
  "subtotal": 199.98,
  "discountAmount": 39.996,
  "totalAmount": 159.984,
  "discountCode": "SAVE20",
  "discountPercentage": 20
}
```

## 💳 Checkout & Order Endpoints

### Process Checkout

**Endpoint**: `POST /checkout`

**Description**: Process checkout and create order

**Headers**: `Authorization: Bearer <token>`

**Request Body**:
```json
{
  "paymentMethod": "credit_card",
  "paymentDetails": {
    "cardNumber": "4111111111111111",
    "expiryMonth": 12,
    "expiryYear": 2025,
    "cvv": "123",
    "holderName": "John Doe"
  },
  "shippingAddress": {
    "street": "123 Test St",
    "city": "Test City",
    "state": "TS",
    "zipCode": "12345",
    "country": "USA"
  },
  "billingAddress": {
    "street": "123 Test St",
    "city": "Test City",
    "state": "TS",
    "zipCode": "12345",
    "country": "USA"
  }
}
```

**Response**:
```json
{
  "orderId": 789,
  "orderNumber": "ORD-2024-001",
  "status": "confirmed",
  "paymentStatus": "paid",
  "totalAmount": 199.98,
  "items": [
    {
      "productId": 1,
      "quantity": 2,
      "price": 99.99,
      "totalPrice": 199.98
    }
  ],
  "shippingAddress": {
    "street": "123 Test St",
    "city": "Test City",
    "state": "TS",
    "zipCode": "12345",
    "country": "USA"
  },
  "estimatedDelivery": "2024-01-08T00:00:00Z",
  "createdAt": "2024-01-01T10:00:00Z"
}
```

### Get Order Details

**Endpoint**: `GET /orders/{id}`

**Description**: Get detailed order information

**Headers**: `Authorization: Bearer <token>`

**Response**:
```json
{
  "orderId": 789,
  "orderNumber": "ORD-2024-001",
  "status": "shipped",
  "paymentStatus": "paid",
  "totalAmount": 199.98,
  "items": [
    {
      "productId": 1,
      "quantity": 2,
      "price": 99.99,
      "totalPrice": 199.98,
      "product": {
        "title": "Product Name",
        "image": "https://example.com/image.jpg"
      }
    }
  ],
  "shippingAddress": {
    "street": "123 Test St",
    "city": "Test City",
    "state": "TS",
    "zipCode": "12345",
    "country": "USA"
  },
  "trackingNumber": "TRACK123456789",
  "estimatedDelivery": "2024-01-08T00:00:00Z",
  "createdAt": "2024-01-01T10:00:00Z",
  "updatedAt": "2024-01-02T15:30:00Z"
}
```

### Get Order Status

**Endpoint**: `GET /orders/{id}/status`

**Description**: Get current order status

**Headers**: `Authorization: Bearer <token>`

**Response**:
```json
{
  "orderId": 789,
  "status": "shipped",
  "paymentStatus": "paid",
  "shippingStatus": "in_transit",
  "estimatedDelivery": "2024-01-08T00:00:00Z",
  "trackingNumber": "TRACK123456789",
  "lastUpdated": "2024-01-02T15:30:00Z"
}
```

### Get Order History

**Endpoint**: `GET /orders`

**Description**: Get user's order history

**Headers**: `Authorization: Bearer <token>`

**Query Parameters**:
- `page`: Page number (default: 1)
- `limit`: Items per page (default: 10)
- `status`: Filter by status
- `startDate`: Filter start date
- `endDate`: Filter end date

**Response**:
```json
{
  "orders": [
    {
      "orderId": 789,
      "orderNumber": "ORD-2024-001",
      "status": "shipped",
      "totalAmount": 199.98,
      "createdAt": "2024-01-01T10:00:00Z"
    }
  ],
  "totalCount": 5,
  "currentPage": 1,
  "totalPages": 1
}
```

### Cancel Order

**Endpoint**: `POST /orders/{id}/cancel`

**Description**: Cancel an order

**Headers**: `Authorization: Bearer <token>`

**Request Body**:
```json
{
  "reason": "Customer request"
}
```

**Response**:
```json
{
  "orderId": 789,
  "status": "cancelled",
  "refundStatus": "processing",
  "message": "Order cancelled successfully"
}
```

### Reorder Items

**Endpoint**: `POST /orders/{id}/reorder`

**Description**: Add items from previous order to cart

**Headers**: `Authorization: Bearer <token>`

**Response**:
```json
{
  "message": "Items added to cart successfully",
  "itemsAdded": 2,
  "cartTotal": 199.98
}
```

## ❌ Error Responses

### Standard Error Format

```json
{
  "error": {
    "message": "Error description",
    "code": "ERROR_CODE",
    "field": "field_name",
    "details": {
      "additional": "information"
    }
  }
}
```

### Common Error Codes

| Code | Description | HTTP Status |
|------|-------------|-------------|
| `UNAUTHORIZED` | Authentication required | 401 |
| `FORBIDDEN` | Insufficient permissions | 403 |
| `NOT_FOUND` | Resource not found | 404 |
| `VALIDATION_ERROR` | Input validation failed | 400 |
| `INVALID_CREDENTIALS` | Wrong username/password | 401 |
| `TOKEN_EXPIRED` | Access token expired | 401 |
| `INSUFFICIENT_INVENTORY` | Not enough stock | 409 |
| `PAYMENT_FAILED` | Payment processing failed | 402 |
| `EMPTY_CART` | Cannot checkout empty cart | 400 |

## 🚦 Rate Limiting

### Rate Limits

| Endpoint | Limit | Window |
|----------|-------|--------|
| Authentication | 5 requests | 1 minute |
| Product Search | 100 requests | 1 minute |
| Cart Operations | 50 requests | 1 minute |
| Checkout | 10 requests | 1 minute |

### Rate Limit Headers

```http
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1640995200
```

### Rate Limit Exceeded Response

```json
{
  "error": {
    "message": "Rate limit exceeded",
    "code": "RATE_LIMIT_EXCEEDED",
    "retryAfter": 60
  }
}
```

## 🔐 Authentication

### Bearer Token Authentication

Include access token in Authorization header:

```http
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### Token Expiration

- **Access Token**: 1 hour
- **Refresh Token**: 30 days

### Token Refresh Flow

1. Use refresh token to get new access token
2. Update Authorization header with new token
3. Continue API calls with new token

---

**Note**: This documentation covers the API endpoints tested by the Karate framework. For actual implementation details, refer to the respective API service documentation.
