#####################################################################
## Copyright 2021 Philip Morris Products, S.A.
## Quai Jeanrenaud 5, 2000 Neuchatel, Switzerland
#####################################################################

#' Exports the network backbone as tsv file
#'
#' @param net A R6 NPAModel object
#' @param output_path A string correspond to the tsv output filepath.
#' If not provided, ``backbone.tsv`` will be generated in working directory.
#' @return Nothing is returned. File is created.
#' @export

exportBackbone <- function(net, output_path=file.path(getwd(), 'backbone.tsv')) {
    net <- net$get_data()
    edges <- net$model$edges
    df <- data.frame(SourceNode=edges$Source.Node, Direction=edges$Direction,
                     TargetNode=edges$Target.Node)
    write.table(df, file=output_path, quote=FALSE, sep='\t', row.names=FALSE)
}

#' Exports the network downstreams as tsv file
#'
#' @param net A R6 NPAModel object
#' @param output_path A string correspond to the tsv output filepath.
#' If not provided, ``downstream.tsv`` will be generated in working directory.
#' @return Nothing is returned. File is created.
#' @export

exportDownstreams <- function(net, output_path=file.path(getwd(), 'downstream.tsv')) {
    net <- net$get_data()
    df <- data.frame()
    for (inode_idx in seq_along(net$startNodeDown)) {
        current_df <- net$startNodeDown[[inode_idx]]
        parent_node <- rep(names(net$startNodeDown[inode_idx]), nrow(current_df))
        current_df$InodeLabel <- parent_node
        df <- rbind(df, current_df)
    }
    write.table(df, file=output_path, quote=FALSE, sep='\t', row.names=FALSE)
}