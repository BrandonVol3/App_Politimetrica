import 'package:flutter/material.dart';
import '../models/politician.dart';

class PoliticianCard extends StatefulWidget {
  final Politician politician;
  final VoidCallback onTap;

  const PoliticianCard({
    super.key,
    required this.politician,
    required this.onTap,
  });

  @override
  State<PoliticianCard> createState() => _PoliticianCardState();
}

class _PoliticianCardState extends State<PoliticianCard> with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 0.97);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: true,
      label: 'Tarjeta de político ${widget.politician.name}',
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Ink(
              color: Colors.white,
              child: InkWell(
                splashColor: Colors.blue.withOpacity(0.1),
                highlightColor: Colors.transparent,
                onTap: widget.onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildImage(),
                      const SizedBox(width: 16),
                      Expanded(child: _buildInfo(theme)),
                      const SizedBox(width: 12),
                      _buildApprovalWithSemantics(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Semantics(
      image: true,
      label: 'Foto de ${widget.politician.name}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          widget.politician.imageUrl,
          width: 64,
          height: 64,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 64,
              height: 64,
              color: Colors.grey.shade200,
              child: const Icon(Icons.person, size: 32, semanticLabel: 'Icono de persona'),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfo(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.politician.name,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          widget.politician.position,
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildPartyDot(),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.politician.party,
                style: TextStyle(
                  color: _parseColor(widget.politician.partyColor),
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPartyDot() {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: _parseColor(widget.politician.partyColor),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildApprovalWithSemantics() {
    return Semantics(
      label: 'Índice de aprobación de ${widget.politician.approvalRating.toStringAsFixed(0)}%',
      child: ExcludeSemantics(child: _buildApprovalIndicator()),
    );
  }

  Widget _buildApprovalIndicator() {
    final rating = widget.politician.approvalRating;
    final color = _approvalColor(rating);

    return SizedBox(
      width: 42,
      height: 42,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: rating / 100,
            color: color,
            backgroundColor: Colors.grey.shade300,
            strokeWidth: 5,
          ),
          Text(
            '${rating.toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _approvalColor(double rating) {
    if (rating > 70) return Colors.green;
    if (rating > 50) return Colors.orange;
    return Colors.red;
  }

  Color _parseColor(String hexColor) {
    return Color(int.parse('0xFF$hexColor'));
  }
}
