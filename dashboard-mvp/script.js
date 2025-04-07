console.log("SplitStream Dashboard MVP script loaded.");

// --- Clerk Integration ---

// IMPORTANT: Replace this with your actual Clerk Publishable Key
const CLERK_PUBLISHABLE_KEY = "pk_test_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"; // PASTE YOUR KEY HERE

const authContainer = document.getElementById("auth-container");
const loggedInContent = document.getElementById("logged-in-content");
const loggedOutContent = document.getElementById("logged-out-content");

// Function to handle authentication state changes
function handleClerkStateChange(event) {
	console.log("Clerk state changed:", event);
	const clerk = window.Clerk; // Access Clerk instance from window

	if (!clerk || !authContainer || !loggedInContent || !loggedOutContent) {
		console.error("Clerk instance or required elements not found.");
		return;
	}

	if (clerk.user) {
		// User is logged in
		console.log("User is logged in:", clerk.user.id);
		loggedInContent.style.display = "block";
		loggedOutContent.style.display = "none";
		// Unmount any existing Clerk component
		clerk.unmountComponent({ node: authContainer });
	} else {
		// User is logged out
		console.log("User is logged out.");
		loggedInContent.style.display = "none";
		loggedOutContent.style.display = "block";
		// Mount the Sign Up component
		try {
			clerk.mountSignUp(authContainer);
			console.log("Clerk SignUp component mounted.");
		} catch (error) {
			console.error("Error mounting Clerk SignUp component:", error);
		}
	}
}

// Wait for Clerk to be ready before adding the listener
// The script tag in index.html initializes window.Clerk and calls load()
// We need to ensure Clerk is loaded before adding listeners or mounting.
// A simple check and delay might be needed if the listener setup runs too early.
// However, Clerk's `load()` handles asynchronous loading, and the listener
// should fire correctly once the state is determined.

// Add the listener once Clerk is likely available
// A more robust way might involve checking window.Clerk in an interval,
// but let's rely on the script loading order and Clerk's internal readiness for now.
if (window.Clerk) {
	window.Clerk.addListener(handleClerkStateChange);
	// Initial check in case the state is already determined when the listener is added
	handleClerkStateChange({ session: window.Clerk.session, user: window.Clerk.user });
} else {
	// Fallback if Clerk wasn't immediately ready (might happen with async loading)
	// Listen for the custom event Clerk might dispatch or use an interval
	console.warn("Clerk instance not immediately available. Listener might be delayed.");
	// A simple interval check as a fallback
	const clerkCheckInterval = setInterval(() => {
		if (window.Clerk && window.Clerk.loaded) {
			clearInterval(clerkCheckInterval);
			console.log("Clerk loaded, adding listener.");
			window.Clerk.addListener(handleClerkStateChange);
			// Initial check
			handleClerkStateChange({ session: window.Clerk.session, user: window.Clerk.user });
		}
	}, 100); // Check every 100ms
}
