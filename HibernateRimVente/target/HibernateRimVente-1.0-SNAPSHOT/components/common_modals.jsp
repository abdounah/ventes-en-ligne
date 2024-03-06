<script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI/tZ1oFYkUTFG9z1Zu6Hk9OX/Yl0jFRQnJirR6g=" crossorigin="anonymous"></script>

<script>
    function updateCart() {
        console.log("Updating cart...");

        // Get the cart items from local storage
        const cartString = localStorage.getItem("cart");
        let cart;

        // Parse the JSON string, handling potential errors gracefully
        try {
            cart = JSON.parse(cartString);
        } catch (error) {
            console.error("Error parsing cart:", error);
            cart = []; // Set an empty array if parsing fails
        }

        console.log("Cart after parsing:", cart);

        // Check if the cart is empty
        if (!cart || cart.length === 0) {
            console.log("Cart is empty.");
            const cartItemsElement = document.querySelector(".cart-items");
            cartItemsElement.textContent = "(0)";

            const cartBodyElement = document.querySelector(".cart-body");
            cartBodyElement.innerHTML = "<h3>vide</h3>";

            const checkoutButtonElement = document.querySelector(".checkout-btn");
            checkoutButtonElement.classList.add("disabled");
        } else {
            console.log("Updating cart contents...");
            // Add logic to update cart items, total price, etc. based on your specific requirements
        }
    }

    $(document).ready(function () {
        updateCart();
    });
</script>
<!-- Modal -->
<div class="modal fade" id="cart" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Votre panier</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="cart-body">

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
                <button type="button" class="btn btn-primary checkout-btn">Payer</button>
            </div>
        </div>
    </div>
</div>