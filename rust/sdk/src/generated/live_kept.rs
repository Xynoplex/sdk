// Generated from protocol/specs/src/client/refresh.json; do not edit.
// Regenerate: make generate (codegen/lib/cache_refresh/rust.ml)
impl Live {
    /// The cache of each query protocol/specs/src/client/refresh.json persists, in the table's order.
    fn kept(&self) -> [(CacheQuery, &dyn Kept); 5] {
        [
            (CacheQuery::Resource, &self.resource),
            (CacheQuery::Annotations, &self.annotations),
            (CacheQuery::Annotation, &self.annotation),
            (CacheQuery::EntityTypes, &self.entity_types),
            (CacheQuery::TagSchemas, &self.tag_schemas),
        ]
    }
}
