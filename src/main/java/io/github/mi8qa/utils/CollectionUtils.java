package io.github.mi8qa.utils;

import java.util.*;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

/**
 * Utility class for working with collections.
 */

public class CollectionUtils {

	/**
	 * Sorts a list using a comparator.
	 *
	 * @param <T>        The type of elements in the list.
	 * @param list       The list to be sorted.
	 * @param comparator The comparator used for sorting.
	 *
	 * @return A sorted list.
	 */

	public static <T> List<T> sortByComparator(List<T> list, Comparator<T> comparator) {
		return list.stream()
				.sorted(comparator)
				.collect(Collectors.toList());
	}

	/**
	 * Orders a map by its keys.
	 *
	 * @param <K> The type of keys in the map.
	 * @param <V> The type of values in the map.
	 * @param map The map to be ordered.
	 *
	 * @return A LinkedHashMap ordered by keys.
	 */
	public static <K extends Comparable<? super K>, V> LinkedHashMap<K, V> orderByKey(Map<K, V> map) {
		return order(map, Map.Entry.comparingByKey());
	}

	/**
	 * Orders a map using a custom comparator.
	 *
	 * @param <K>        The type of keys in the map.
	 * @param <V>        The type of values in the map.
	 * @param map        The map to be ordered.
	 * @param comparator The comparator used for ordering.
	 *
	 * @return A LinkedHashMap ordered based on the provided comparator.
	 */
	public static <K, V> LinkedHashMap<K, V> order(Map<K, V> map, Comparator<Map.Entry<K, V>> comparator) {
		return map.entrySet().stream()
				.sorted(comparator)
				.collect(Collectors.toMap(
						Map.Entry::getKey,
						Map.Entry::getValue,
						(e1, e2) -> e1,
						LinkedHashMap::new
				));
	}

	/**
	 * Transforms a map by applying a transformation function to selected entries.
	 *
	 * @param initialMap        The initial map to be transformed.
	 * @param isSensitive       A predicate to determine if an entry should be transformed.
	 * @param transformFunction The function to apply to entries that meet the predicate condition.
	 *
	 * @return The transformed map.
	 */

	public static Map<String, String> transformMap(Map<String, String> initialMap, Predicate<Map.Entry<String, String>> isSensitive, Function<Map.Entry<String, String>, Map.Entry<String, String>> transformFunction) {
		return initialMap.entrySet().stream()
				.map(entry -> isSensitive.test(entry) ? transformFunction.apply(entry) : entry)
				.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
	}

	/**
	 * Transforms a list by applying a transformation function to selected elements.
	 *
	 * @param <T>               The type of elements in the list.
	 * @param initialList       The initial list to be transformed.
	 * @param isSensitive       A predicate to determine if an element should be transformed.
	 * @param transformFunction The function to apply to elements that meet the predicate condition.
	 *
	 * @return The transformed list.
	 */

	public static <T> List<T> transformList(List<T> initialList, Predicate<T> isSensitive, Function<T, T> transformFunction) {
		return initialList.stream()
				.map(item -> isSensitive.test(item) ? transformFunction.apply(item) : item)
				.toList();
	}

	/**
	 * Checks if a collection has elements.
	 *
	 * @param collection The collection to check.
	 *
	 * @return True if the collection is not null and not empty, otherwise false.
	 */

	public static boolean hasElements(Collection<?> collection) {
		return Objects.nonNull(collection) && !collection.isEmpty();
	}

	/**
	 * Checks if any elements from one collection exist in another.
	 *
	 * @param <T>                The type of elements in the collections.
	 * @param originalCollection The original collection.
	 * @param collection         The collection to compare against the original.
	 *
	 * @return True if any elements from the original collection exist in the second collection, otherwise false.
	 */
	public static <T> boolean containsAnyOriginal(Collection<T> originalCollection, Collection<T> collection) {
		return hasElements(originalCollection) && originalCollection.stream().anyMatch(collection::contains);
	}

	/**
	 * Checks if any keys from a collection exist in a map.
	 *
	 * @param originalMap The original map.
	 * @param keys        The collection of keys to check.
	 *
	 * @return True if any keys from the collection exist in the original map, otherwise false.
	 */
	public static boolean containsAnyOriginalKeys(Map<String, String> originalMap, Collection<String> keys) {
		return hasElements(originalMap.keySet()) && keys.stream().anyMatch(originalMap::containsKey);
	}
}
