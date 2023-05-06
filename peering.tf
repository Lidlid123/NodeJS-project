resource "aws_vpc_peering_connection" "peer" {
  vpc_id      = module.vpc.vpc_id
  peer_vpc_id = var.peer_vpc_id
  auto_accept = true
}

resource "aws_route" "private" {
  route_table_id            = module.vpc.private_route_table_ids[0]
  destination_cidr_block    = var.peer_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}


resource "aws_route" "default" {
  route_table_id            = var.default_route_table_id
  destination_cidr_block    = var.peer_vpc_cidr_new
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}