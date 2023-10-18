package io.github.mi8qa.restassured.context;

import java.util.EnumSet;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Interface for types that are considered sensitive.
 * Provides utility methods for dealing with sensitive types.
 * <p>
 * This interface is designed to be implemented by enum classes representing sensitive data types.
 * It includes utility methods for collecting the values of all constants in an enum class that implements SensitiveType
 * and for retrieving the value associated with a sensitive type.
 *
 * @since [Date or Version]
 */
public interface SensitiveType {

	/**
	 * Collects the values of all constants in an enum class that implements SensitiveType.
	 *
	 * @param <E>   The enum type that must implement SensitiveType.
	 * @param clazz The enum class.
	 *
	 * @return A set containing the values of all constants in the enum class.
	 */
	static <E extends Enum<E> & SensitiveType> Set<String> collectEnumValues(Class<E> clazz) {
		return EnumSet.allOf(clazz).stream()
				.map(SensitiveType::getValue)
				.collect(Collectors.toSet());
	}

	/**
	 * Retrieves the value associated with a sensitive type.
	 *
	 * @return The value of the sensitive type.
	 */
	String getValue();
}
