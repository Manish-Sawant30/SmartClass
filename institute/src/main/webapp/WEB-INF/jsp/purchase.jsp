<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>EduEra - Checkout</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #0a3d62, #3c6382);
            font-family: Arial, sans-serif;
        }

        h2 {
            text-align: center;
            color: #fff;
            margin-top: 30px;
            font-size: 32px;
        }

        .checkout-box {
            background: #fff;
            width: 75%;
            margin: auto;
            margin-top: 40px;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0px 8px 20px rgba(0,0,0,0.3);
        }

        .course-preview {
            text-align: center;
        }

        .course-preview img {
            width: 70%;
            height: 250px;
            border-radius: 12px;
            object-fit: cover;
        }

        .course-name {
            font-size: 26px;
            color: #0a3d62;
            margin-top: 15px;
            font-weight: bold;
        }

        .price {
            font-size: 24px;
            text-align: center;
            color: #1e6091;
            margin-bottom: 25px;
        }

        .payment-section {
            margin-top: 20px;
        }

        .payment-section h3 {
            color: #0a3d62;
            margin-bottom: 10px;
        }

        .payment-option {
            background: #eef6fb;
            padding: 12px;
            margin-bottom: 10px;
            border-radius: 8px;
        }

        label {
            font-size: 18px;
            color: #333;
            cursor: pointer;
        }

        input[type="text"], input[type="number"] {
            width: 90%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #bcd0e0;
            margin-top: 8px;
            margin-bottom: 10px;
        }

        .pay-btn {
            display: block;
            width: 60%;
            margin: auto;
            padding: 14px;
            text-align: center;
            background: linear-gradient(to right, #0a3d62, #1e6091);
            color: #fff;
            border-radius: 10px;
            font-weight: bold;
            font-size: 20px;
            text-decoration: none;
            margin-top: 25px;
            transition: 0.3s;
        }

        .pay-btn:hover {
            transform: scale(1.04);
            background: linear-gradient(to right, #062c45, #164d75);
        }
    </style>
</head>

<body>

<h2>Checkout - Complete Your Purchase</h2>

<div class="checkout-box">

    <!-- Course Preview -->
    <div class="course-preview">
        <img src="https://i.ibb.co/4K9BPSp/cpp.jpg" alt="Course Image">
        <h3 class="course-name">C++ Programming Masterclass</h3>
        <p class="price">Price: ₹499 Only</p>
    </div>

    <!-- Payment Section -->
    <div class="payment-section">
        <h3>Select Payment Method</h3>

        <div class="payment-option">
            <input type="radio" id="upi" name="method">
            <label for="upi">UPI Payment (Google Pay / PhonePe / Paytm)</label>
        </div>

        <div class="payment-option">
            <input type="radio" id="debit" name="method">
            <label for="debit">Debit / Credit Card</label>
        </div>

        <div class="payment-option">
            <input type="radio" id="netbank" name="method">
            <label for="netbank">Net Banking</label>
        </div>

        <div class="payment-option">
            <input type="radio" id="cash" name="method">
            <label for="cash">Cash Payment at Center</label>
        </div>
    </div>

    <!-- Payment Details Box -->
    <div style="margin-top: 25px;">
        <h3 style="color:#0a3d62;">Payment Details</h3>
        
        <input type="text" placeholder="Enter Your Full Name">
        <input type="text" placeholder="Enter Your Email">
        <input type="number" placeholder="Enter Your Mobile Number">
        
        <input type="text" placeholder="Enter UPI ID (If UPI Selected)">
        <input type="number" placeholder="Card Number (If Card Selected)">
        <input type="text" placeholder="Bank Name (If Net Banking Selected)">
    </div>

    <!-- Pay Button -->
    <a href="#" class="pay-btn">Complete Payment</a>

</div>
</body>
</html>
