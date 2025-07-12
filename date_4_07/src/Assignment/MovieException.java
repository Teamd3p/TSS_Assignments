package Assignment;

public class MovieException {
	public static class MovieStoreAlreadyFull extends RuntimeException {
        public MovieStoreAlreadyFull(String message) {
            super(message);
        }
    }

    public static class MovieStoreEmpty extends RuntimeException {
        public MovieStoreEmpty(String message) {
            super(message);
        }
    }

}
